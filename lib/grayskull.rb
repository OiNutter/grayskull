require 'grayskull/version'

# Base module for gem.
module Grayskull
  autoload :Formats, 'grayskull/formats'
  autoload :DataFile, 'grayskull/datafile'
  autoload :Validator, 'grayskull/validator'
  autoload :CLI, 'grayskull/cli'
end
