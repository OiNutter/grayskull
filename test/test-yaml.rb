require 'yaml'
require_relative '../lib/grayskull/formats/yaml_handler'
require_relative '../lib/grayskull/formats'
require_relative '../lib/grayskull/validator'


path = File.expand_path(File.join(File.dirname(__FILE__), "yaml/file.yml"))
schema = File.expand_path(File.join(File.dirname(__FILE__), "yaml/schema.yml"))
yaml = YAML.load(path)
validator = Grayskull::Validator.new(yaml,schema)

puts validator.validate
