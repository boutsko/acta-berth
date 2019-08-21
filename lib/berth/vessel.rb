# -*- coding: utf-8 -*-

require 'yaml'
require 'ostruct'

class Vessel
  attr_accessor :vess
  def initialize
    quest = YAML::load_file(".quest.yml").to_hash
    @vess = OpenStruct.new(quest)
  end
  
  def print_name
    puts @vess._name
  end

end

