#!/usr/bin/env ruby

require_relative "parser.rb"

class ParseTaman < Parser

  def Parser.file_to_parse 
    "#{bin_dir}/quests/quest_taman.txt"
  end

  def Parser.quest_hash_pairs
    YAML::load_file("#{Parser.bin_dir}/yamls/taman.yml").to_hash
  end

end

f = ParseTaman.new
f.rotate



