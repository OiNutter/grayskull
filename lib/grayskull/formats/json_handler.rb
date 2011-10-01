require 'json'

module Grayskull
  
  module Formats
    
    class JSONHandler
      
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