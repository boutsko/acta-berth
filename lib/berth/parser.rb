# coding: utf-8
#!/usr/bin/env ruby

require 'yaml'

class Parser

  class << self
    attr_accessor :location

    def lib_dir
      File.expand_path File.dirname(__FILE__)
    end

    def file_to_parse
      "quest.txt"
    end

    def prepare_questionnaire
      out_file_tmp = File.open('.quest.tmp', 'w')
      IO.foreach(file_to_parse) do |line|
        line.scrub! # same as above for ruby <2.2
        line.gsub!(/\s\s*/, " ")
        if line =~ /^\-?(\d\.?\d\d?)/  # remove d- dash
          line.gsub!(/\n$/, "") # remove /n from end of ^\d\d lines
          line.gsub!(/^/,"\n") # add /n ti beginning of every \d\d line
        else 
          line.gsub!(/\n$/, " ") # assemble intermidiate lines into one ^\d\d
        end
        out_file_tmp.print line 
      end
      out_file_tmp.rewind
    end

    def text_line(item)
      bar = /^[-\s]*#{item}.*?:[ \s]*([-\w\d\/ ]+)/
    end

    def number_line(item)
      bar = /^[-\s]*#{item}.*?:([0-9.,]+)/
    end

    def quest_hash_pairs
      YAML::load_file("#{lib_dir}/yamls/#{location}.yml").to_hash
    end

  end
  
  def initialize(location)
    Parser.location = location
  end

  def rotate
    Parser.prepare_questionnaire
    @out_file = File.open('.quest.yml', 'w')
    add_bplate_header
    IO.foreach('.quest.tmp') do |line|
      line.gsub!(/\s\s*/, " ")
      Parser.quest_hash_pairs.each do |key, value|
        stuff = sprintf("%-40s : %s\n" ,key ,$1) if line.match(Parser.method(value[1]).call(value[0]))
        @out_file.write stuff
      end
    end
    add_issc_values
    @out_file.close
  end
  
  def add_bplate_header
    @out_file.puts "digest                                   : #{Parser.location}"
    @out_file.puts "name_ru                                  :"
    @out_file.puts "flag_ru                                  :"
    @out_file.puts "last_port                                :"
    @out_file.puts "last_departure_date                      :"
    @out_file.puts "arrival_ts                               :"
    @out_file.puts "departure_ts                             :"
    @out_file.puts "#----------------------------------------------------------------------"
    @out_file.puts "_rgt                                     :"
    @out_file.puts "_reduced_gt                              :"
    @out_file.puts "#----------------------------------------------------------------------"
  end
  
  def add_issc_values
    @out_file.puts "_issc_issued                             :"
    @out_file.puts "_issc_valid                              :"
  end

end

if __FILE__==$0
  Parser.prepare_questionnaire
  f = Parser.new(ARGV[0])
  f.rotate
end
