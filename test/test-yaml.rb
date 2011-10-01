require_relative '../lib/grayskull/formats/yaml_handler'
require_relative '../lib/grayskull/formats'
require_relative '../lib/grayskull/validator'


path = File.expand_path(File.join(File.dirname(__FILE__), "yaml/file.yml"))
schema = File.expand_path(File.join(File.dirname(__FILE__), "yaml/schema.yml"))

validator = Grayskull::Validator.new(path,schema)

validator.validate
