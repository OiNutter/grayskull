require 'yaml'

module Grayskull
  
  module Formats
    
    class YAMLHandler
      
      def self.load(file)
        begin
          return YAML.load_file(file)
        rescue Error => e
          raise e.class, 'File could not be parsed as valid YAML'          
        end
      end
      
    end
    
  end
  
end