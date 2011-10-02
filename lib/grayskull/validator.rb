module Grayskull
  
  # The *Validator* class contains the core methods of the Grayskull library.
  # It loads the passed files, converts them to Ruby types and validates them.
  class Validator
    
    # Creates a new *Validator* instance
    def initialize(file,schema)
      
      @file = file
      @schema = schema
      
      if !Formats::FILENAME_PATTERN.match(file).nil?
        @loaded_file = self.load(file)
      else
        @loaded_file = file
      end
      
      if !Formats::FILENAME_PATTERN.match(schema).nil?
        @loaded_schema = self.load(schema)
      else
        @loaded_schema = schema
      end
      
      @types = @loaded_schema['types'] || {}
      
      @errors = []
    end
    
    # Loads the specified file depending on the format
    def load(file)
     
      format = Formats::detect_format File.basename(file)
     
      case format
        when 'yaml'
          return Formats::YAMLHandler.load(file)
        when 'json'
          return Formats::JSONHandler.load(file)
       end
       
    end
    
    # Validates the file against the schema
    def validate()
       failed = []
        
        @loaded_schema['sections'].each{
          |section|
          
          #check required sections are there
          if (section['required'] && !@loaded_file.has_key?(section['name']))
            @errors.push('Error: missing required section - ' + section['name'])
            failed.push(section['name'])
          elsif @loaded_file.has_key?(section['name'])
            node = @loaded_file[section['name']]
            validated = match_node(node,section,section['name'])
            if(!validated)
              failed.push(section['name'])
            end
          end
               
        }
        
        result = {}       
        result["result"] = failed.empty?
        
        if !failed.empty? && !@errors.empty?
          result["errors"] = @errors
        end
        
        return result
      end
      
      # Checks file node matches the schema.
      #
      # Checks type of node against expected type and 
      # checks any children are of the accepted types.
      def match_node(node,expected,label)
        
        #check type 
        if !check_type(node,expected['type'],label,expected['ok_empty'])
          return false
        end
        
        if (node.kind_of?(Hash) || node.kind_of?(Array))
          
          if node.empty? && !expected['ok_empty']
            @errors.push('Error: node ' + label + ' cannot be empty')
            return false
          elsif !node.empty? && expected.has_key?('accepts')
            valid_content = false
            
            if node.kind_of?(Hash)
              matched = []
              unmatched = []
              node.each_pair{
                |key,value|
                
                expected['accepts'].each{
                  |accepts|
                     
                  result = check_type(value,accepts,key)
                  
                  if result
                    matched.push(key)
                    if !unmatched.find_index(key).nil?
                      unmatched.slice(unmatched.find_index(key))
                    end
                    break
                  else
                    unmatched.push(key)
                  end
                 
                }
                
              }
                   
              if(matched.count==node.count)
                valid_content = true
               else
                unmatched.each{
                  |node|
                  
                  @errors.push('Error: node ' + node + ' is not of an accepted type. Should be one of ' + expected['accepts'].join(', '))
                }
              end
              
            elsif node.kind_of?(Array)
              matched = []
              unmatched = []
              node.each_index{
                |n|
                
                expected['accepts'].each{
                  |accepts|
                  
                  key = label + '[' + n.to_s + ']'
                  result = check_type(node[n],accepts,key)
                  
                  if result
                    
                    matched.push(key)
                    if !unmatched.find_index(key).nil?
                      unmatched.slice(unmatched.find_index(key))
                    end
                    break
                  else
                    unmatched.push(key)
                  end
                  
                }
              }
              
              if(matched.count==node.count)
                valid_content = true
              else
                unmatched.each{
                  |node|
                  
                  @errors.push('Error: node ' + node + ' is not of an accepted type. Should be one of ' + expected['accepts'].join(', '))
                }
              end
            
            end
            
            if !valid_content
              @errors.push('Error: node ' + label + ' contains an unaccepted type.')
              return false
            end
         end
         
        end
       
        return true
                
      end
      
      # Checks that the node is of the correct type
      #
      # If the expected node is a custom node type as defined in the schema
      # It will run `match_node` to check that the node schema matches the 
      # custom type.
      def check_type(node,expected_type,label,accept_nil = false)
              
        valid_type = true;
        if(@types.has_key?(expected_type))
          valid_type = match_node(node,@types[expected_type],label)
        elsif node.class.to_s != expected_type && !(node.kind_of?(NilClass) && (expected_type=='empty' || accept_nil))
          valid_type = false
        end
       
        return valid_type
        
      end
      
  end
  
end