unless defined? Grayskull
  $:.unshift File.expand_path("../lib", __FILE__)
  require "grayskull/version"
end

Gem::Specification.new do |s|
  s.name = "grayskull"
  s.version = Grayskull
  s.summary = "Validates data files based on a provided schema"
  s.description = "Will validate YAML and JSON files based on a provided schema"

  s.files = Dir["README", "LICENSE", "lib/**/*.rb","bin/**/*"]
  s.executables = ["grayskull"]
  s.authors = ["Will McKenzie"]
  s.email = ["will@oinutter.co.uk"]
  s.homepage = "http://github.com/OiNutter/grayskull"
  s.rubyforge_project = "grayskull"
  s.licenses = ["MIT"]
  
   s.add_dependency "thor"
  
end

