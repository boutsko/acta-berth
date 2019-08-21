#!/usr/bin/env ruby

require_relative "parser.rb"

class ParseNovo < Parser

  def Parser.file_to_parse 
    "#{bin_dir}/quests/quest_novo.txt"
  end

  def Parser.quest_hash_pairs
    YAML::load_file("#{Parser.bin_dir}/yamls/novo.yml").to_hash
  end

end

f = ParseNovo.new
f.rotate



