require 'thor'

module Grayskull
  
  # The *CLI* class provides an interface for the command line functions 
  class CLI < Thor
    
    desc "validate FILE SCHEMA" ,"Checks TEMPLATE is a valid file and matches SCHEMA."
    # Creates a new *Validator* and validates the file    
    def validate(file,schema)
      validator = Grayskull::Validator.new(file,schema)
      validator.validate
    end
    
  end
  
end