# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'oclc_authoritative/version'

Gem::Specification.new do |spec|
  spec.name          = "oclc_authoritative"
  spec.version       = OclcAuthoritative::VERSION
  spec.authors       = ["Josh Steverman"]
  spec.email         = ["jstever@umich.edu"]
  spec.summary       = %q{Retrieving authoritative OCLCs from db.}
  spec.description   = %q{}
  spec.homepage      = ""

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_dependency "dotenv"
  spec.add_dependency "mongoid"
end
