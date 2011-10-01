require_relative '../lib/grayskull/formats/json_handler'
require_relative '../lib/grayskull/formats'
require_relative '../lib/grayskull/validator'


path = File.expand_path(File.join(File.dirname(__FILE__), "json/file.json"))
schema = File.expand_path(File.join(File.dirname(__FILE__), "json/schema.json"))

validator = Grayskull::Validator.new(path,schema)

puts validator.validate
