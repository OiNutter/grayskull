require 'json'

module Grayskull
  
  module Formats
    
    # Handler for JSON file format.
    class JSONHandler
      
      # Loads the JSON file and parses it into a ruby type.
      #
      # Raises an expection if file can not be parsed.
       def self.load(file)
         loaded = File.open(file)
         content = loaded.gets nil
        begin
          return JSON.parse(content)
        rescue Exception => e
          raise e.class, 'File could not be parsed as valid JSON'          
        end
      end
      
    end
    
  end
  
end