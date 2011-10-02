module Grayskull
  
  # The *Formats* module contains handlers for all the supported formats and 
  # methods for format detection.
  module Formats
    
    autoload :YAMLHandler, 'grayskull/formats/yaml_handler'
    autoload :JSONHandler, 'grayskull/formats/json_handler'
    
    # Regular Expression to get file extension.
    FILENAME_PATTERN = /(.+)\.([^\/\.]+)/
    
    # Gets the file extension of the given file and returns the file format.
    #
    # Raises an exception if file is not of a valid type.
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