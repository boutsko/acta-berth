#!/Users/sampai/.rbenv/versions/2.2.1/bin/ruby
# -*- coding: utf-8 -*-
require 'watir-webdriver'
require 'ostruct'
require 'highline/import'

class Rmp < OpenStruct
  def initialize
    quest = YAML::load_file(".quest.yml").to_hash
    super(quest)

    @b = Watir::Browser.new :chrome
  end

  def login
    @b.goto 'rmpnovo.ru'
    @b.text_field(:name => 'USR').set '23522'
    @b.text_field(:name => 'PWD').set '310896'
    @b.button(:name => 'submit').click
    @b.link(:text => 'Заявки на подход').click
    @b.link(:text => 'Оформить новую').click
    @b.text_field(:name => 'Код ИМО093').set _imo
    @b.link(:text => 'отфильтровать').click
    @b.link(:text => /#{_name}/i).click
    @b.windows.last.use do
      @b.text_field(:name => 'n_flag').set _flag
      @b.text_field(:name => 'n_callsign').set _call_sign
      @b.text_field(:name => 'n_portreg').set _port_reg
      @b.text_field(:name => 'n_owner').set _owner

      @b.select_list(:name, "n_TargetNotice").select_value("1")
      if (digest =~ /^s2/i && _dwt.to_i > 89999)
        raise "dwt exceeds permitted for SHS 2"
      end
      @b.select_list(:name, "n_MainEng").select_value("Дизель")
      @b.text_field(:name => 'n_pEmg').set _me_power #"12000"
      @b.text_field(:name => 'n_dwt').set _dwt
      @b.text_field(:name => 'n_ballast').set _ballast
      @b.text_field(:name => 'n_dhn').set _draft_arrival_fore
      @b.text_field(:name => 'n_dhk').set _draft_arrival_aft

      if (digest =~ /^s/i)
        @b.select_list(:name, "stividor").select_value("1")
      elsif (digest =~ /^c/i)
        @b.select_list(:name, "stividor").select_value("13")
      elsif (digest =~ /^i/i)
        @b.select_list(:name, "stividor").select_value("19")
      elsif (digest =~ /^f/i)
        @b.select_list(:name, "stividor").select_value("24")
      end

      @b.checkbox(:id => 'checkdoc').set
      @b.checkbox(:id => 'checksert').set

      @b.text_field(:id => 'LastPort').set last_port
      @b.text_field(:id => 'eta').set arrival_ts

      @b.link(:text => 'Информация о грузах').click
      @b.button(:text => 'Добавить грузовую операцию').click
      @b.select_list(:id, "oDirect0").select_value("1")
      
      if (digest =~ /^s.*c/i)
        # insert co cargo
        @b.select_list(:id, "select0").select_value("155")
      elsif (digest =~ /^[si].*g/i)
        # insert go cargo
        @b.select_list(:id, "select0").select_value("123")
      elsif (digest =~ /^f.*vg/i)
        # insert go cargo
        @b.select_list(:id, "select0").select_value("123")
      elsif (digest =~ /^s.*f/i)
        # insert fo cargo
        @b.select_list(:id, "select0").select_value("19")
      end

      if (digest =~ /^s1c/i)
        @b.text_field(:id => 'Ttext0').set '140000'
      elsif (digest =~ /^s2c/i)
        @b.text_field(:id => 'Ttext0').set '80000'
      elsif (digest =~ /^s6c/i)
        @b.text_field(:id => 'Ttext0').set '60000'
      elsif (digest =~ /[gf]o?$/i)
        @b.text_field(:id => 'Ttext0').set '30000'
      elsif (digest =~ /vg$/i)
        @b.text_field(:id => 'Ttext0').set '30000'
      end

      # issc
      @b.link(:text => 'Информация по МК ОСПС').click

      IO.foreach('last10.txt').with_index(1) do |line, i|
        line =~ /^(.*?);\s+([0-9.\/]+);\s+([0-9.\/]+);\s+([0-9])/i

        @b.text_field(:name => "L_port_name#{i}").set $1
        @b.text_field(:name => "L_startdate#{i}").set $2
        @b.text_field(:name => "L_enddate#{i}").set $3
        @b.select_list(:name => "Levels#{i}").select_value("#{$4}")
      end

      @b.text_field(:name => "PROF_CERTNO").set _issc_number
      @b.text_field(:name => "PROF_ISSUE").set _issc_issued
      @b.text_field(:name => "PROF_EXPIRITY").set _issc_valid
      @b.text_field(:name => "PROF_ORG").set _issc_class

      @b.select_list(:name => "PROF_LEVEL_ID").select_value("1")

      confirm = ask("Do it? [Y/N] ") { |yn| yn.limit = 1, yn.validate = /[yn]/i }
      exit unless confirm.downcase == 'y'
      puts "submiting form"
      @b.form(:id,'f1').submit
      sleep 1000
    end
  end

end

rmp = Rmp.new 
rmp.login
