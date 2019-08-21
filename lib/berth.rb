# -*- coding: utf-8 -*-

require_relative 'berth/utils'

require 'rubygems'
require 'berth/os_functions.rb'
require 'berth/monkey_string.rb'
require 'prawn'
require 'prawn/table'
require 'berth/axis.rb'
#require 'berth/vessel.rb'
require 'ostruct'
require 'berth/shore_info.rb'
require 'berth/pilot_order.rb'
require 'berth/tug_order.rb'
require 'berth/terminals.rb'
require 'berth/form.rb'
require 'berth/create_pdf.rb'

config_dir = Foobar::Utils.gem_libdir + '/config/'
raw_config = File.read(config_dir + "config.yaml")
APP_CONFIG = YAML.load(raw_config)[:development]

template_dir = Foobar::Utils.gem_libdir + '/templates/'

class String
  include MonkeyString
end

class Order < OpenStruct
  include Prawn::View
  include Form
  include CreatePdf
  include OsFunctions
  include ShoreInfo
  include PilotOrder
  include TugOrder
  extend Terminals

  attr_accessor :wording
  
  def initialize (*args)
    @berth, @wording, @name = *args
    @t, @b, @g = @berth.match(/([a-z][a-z]*)(\d\d?)(\w*)$/).captures

    Order.set_methods(@t, @b, @g)

    quest = YAML::load_file(".quest.yml").to_hash
    super(quest)

    choose_form #(@wording)
    
  end

  def name
    # cl camel case to name or from .quest.yml
    _name || @name.sub(/([\w]+[^A-Z])([A-Z]\w+)/) { $1 + " " + $2 }.upcase 

  end

end
# thoughts
# can be : -nAegeanAngel -bshs -ja -tt1800
# vessel split name by ^ Cap letter :
# "HelloWorld".sub(/([\w]+[^A-Z])([A-Z]\w+)/) { puts $1 + " " + $2 }
# Hello World
# shs, ipp can be just s and i
# subst "t for today date", make option -t for date, t for today, -t t1800 - looks good, if further, 0 can stand for 00:01.

#----------------------------------------------------------------------
