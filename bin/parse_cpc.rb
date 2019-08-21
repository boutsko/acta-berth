#!/usr/bin/env ruby

require_relative "parser.rb"

class ParseCPC < Parser

  def Parser.file_to_parse 
    "fixtures/quest_cpc.txt"
  end

  def Parser.quest_hash_pairs
    YAML::load_file("#{Parser.lib_dir}/yamls/cpc.yml").to_hash
  end

end

f = ParseCPC.new
f.rotate



