#!/Users/sampai/.rbenv/versions/2.2.1/bin/ruby
# -*- coding: utf-8 -*-
require 'watir-webdriver'
require 'ostruct'
require 'highline/import'

class Rmp < OpenStruct
  def initialize
    quest = YAML::load_file(".quest.yml").to_hash
    super(quest)

    @b = Watir::Browser.new
  end

  def login
    @b.goto 'rmpnovo.ru'
    @b.text_field(:name => 'USR').set '23522'
    @b.text_field(:name => 'PWD').set '310896'
    @b.button(:name => 'submit').click
    @b.link(:text => 'Заявки на подход').click
    @b.link(:text => 'Добавить судно').click
    @b.text_field(:name => 'n_name').set _name
    @b.text_field(:name => 'n_name_full').set _name
    @b.text_field(:name => 'n_name_eng').set _name
    case _flag
    when "MALTA"
      @b.select_list(:name, "n_Flag").select("Мальта")
      # puts @b.select_list.selected_options.map(&:text)
    else
      puts "must add that flag"
    end
#    @b.text_field(:name => 'n_owner').set _owner
    @b.select_list(:name, "n_type").select("Танкер.")
    @b.text_field(:name => 'n_imo').set _imo
    @b.text_field(:name => 'n_callsign').set _call_sign
    @b.text_field(:name => 'reg_port').set _port_reg
    @b.text_field(:name => 'reg_num').set "_register_number"
    @b.text_field(:name => 'n_year').set "_year_built"
    @b.text_field(:name => 'n_loa').set _loa
    @b.text_field(:name => 'n_boa').set _beam
    @b.text_field(:name => 'n_md').set _mdepth
    @b.text_field(:name => 'n_grt').set _gt
    @b.text_field(:name => 'n_nrt').set _nrt
    @b.text_field(:name => 'n_dwt').set _dwt

    # can simply add by pushin "SUBMIT" button

    # confirm = ask("Do it? [Y/N] ") { |yn| yn.limit = 1, yn.validate = /[yn]/i }
    #   exit unless confirm.downcase == 'y'
    #   puts "submiting form"
    #   @b.form(:id,'addShip').submit
    #   sleep 1000
  end
end

rmp = Rmp.new 
rmp.login
