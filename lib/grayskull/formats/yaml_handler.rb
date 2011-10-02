require 'yaml'

module Grayskull
  
  module Formats
    
    # Handler for YAML file format
    class YAMLHandler
      
      # Loads the YAML file and parses it into a ruby type.
      #
      # Raises an expection if file can not be parsed.
      def self.load(file)
        begin
          return YAML.load_file(file)
        rescue Exception => e
          raise e.class, 'File could not be parsed as valid YAML'          
        end
      end
      
    end
    
  end
  
end