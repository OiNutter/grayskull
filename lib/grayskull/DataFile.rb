module Grayskull
  
  # The *DataFile* class contains methods for loading
  # and working with the supported data files.
  class DataFile
    
     # Loads the specified file depending on the format
    def self.load(file)
     
      format = Formats::detect_format File.basename(file)
     
      case format
        when 'yaml'
          return Formats::YAMLHandler.load(file)
        when 'json'
          return Formats::JSONHandler.load(file)
       end
       
    end
    
  end
  
end