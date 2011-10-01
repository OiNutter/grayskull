module Grayskull
  
  module Formats
    
    autoload :YAMLHandler, 'grayskull/formats/yaml_handler'
    autoload :JSONHandler, 'grayskull/formats/json_handler'
    
    FILENAME_PATTERN = /(.+)\.([^\/\.]+)/
    
    def self.detect_format(filename)
      matches = FILENAME_PATTERN.match(filename.downcase).to_a
      if matches
        ext = matches[2]
        case ext
          when 'json'
            return 'json'
          when 'yml'
            return 'yaml'
          else
            raise TypeError, "Not a supported file format: " + ext
        end
      else
        raise LoadError, "Not a valid filename: " + filename
      end
    end
    
  end
  
end