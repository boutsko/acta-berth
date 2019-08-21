# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'berth/version'

Gem::Specification.new do |spec|
  spec.name          = "berth"
  spec.version       = Berth::VERSION
  spec.authors       = ["boutsko"]
  spec.email         = ["boutsko@gmail.com"]
  spec.summary       = %q{create pdf forms for serving to oil terminals}
  spec.description   = %q{cl utility}
  spec.license       = "MIT"
  spec.files = Dir['lib/**/*.rb'] + Dir['lib/**/**/*.*'] + Dir['bin/*']
  spec.executables << 'berth'
  spec.executables << 'rmp.rb'
  spec.executables << 'portcall.rb'
  spec.executables << 'parse.rb'
  spec.executables << 'parser.rb'
  spec.executables << 'rmp_add_ship.rb'
  spec.executables << 'portcall_add_docs.rb'
  spec.executables << 'check-certificates.rb'
  spec.executables << 'console'
  spec.require_paths = ["lib"]

end
