# coding: utf-8
#!/usr/bin/env ruby
require_relative '../lib/berth/parser.rb'

Parser.prepare_questionnaire
f = Parser.new(ARGV[0])
f.rotate
