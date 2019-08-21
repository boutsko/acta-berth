# coding: utf-8
#!/Users/sampai/.rbenv/versions/2.2.1/bin/ruby
# -*- coding: utf-8 -*-
require 'watir-webdriver'
require 'ostruct'


class Portcall < OpenStruct
  def initialize(notice)
    p Dir.pwd
    quest = YAML::load_file(".quest.yml").to_hash
    super(quest)
    @notice = notice
    @b = Watir::Browser.new :chrome, :switches => %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate --disable-notifications --start-maximized --disable-gpu]
    @b.driver.manage.timeouts.implicit_wait = 100 # seconds
  end

  def notice
    @notice
  end
  
  def login
    @b.goto 'portcall.marinet.ru'
    @b.text_field(:name => 'login').set 'almar'
    @b.text_field(:name => 'password').set '4225c4a5'
    @b.link(:text =>"Вход").click
    p "notice : #{notice}"
    choose_action(notice)
  end

  def choose_action (notice)
    case notice
    when "72"
      find_by_imo
    when "24", "10", "_"
      find_from_existing
    when /^c(.*)$/
      @notice = $1
      find_by_imo
    else
      puts "enter correct notice time"
    end
  end

  def find_by_imo
    @b.div(:id => "menu").li(:text => /Суда/).click
    @b.iframe(:name => 'ships').select_list(:name, "Selector").select_value("IMO_No")
    @b.iframe(:name => 'ships').text_field(:name => 'Request').set _imo
    @b.iframe(:name => 'ships').button(:id => 'srchBtn').click

    @b.iframe(:name => 'ships').tds.last.click
    @b.iframe(:name => 'ships').button(:text => "Новый судозаход/судоотход (торг.)").click

    @b.iframe(:name => 'ships').link(:onclick => "transferForm(\"#{notice}\")").when_present.click

    ## if-fork for Novorossiysk/Taman 
    if (digest == "novo")
      @b.iframe(:name => 'ships').select_list(:id => "PortEnter#{notice}").select "Новороссийск-RUNVS"
    end

    if (digest == "cpc")
      @b.iframe(:name => 'ships').select_list(:id => "PortEnter#{notice}").select "Новороссийск-RUNVS"
    end

    if (digest == "taman")
      @b.iframe(:name => 'ships').select_list(:id => "PortEnter#{notice}").select "Тамань-RUTAM"
    end

    fill_data
  end

  def find_from_existing

    fo_arrival, go_arrival = _bunkers_on_arrival.match(/^([\d.]+) \/ ([\d.]+)/i).captures
    fo_departure, go_departure = _bunkers_on_departure.match(/^([\d.]+) \/ ([\d.]+)/i).captures

    @b.iframe(:name => 'enter').td(:text => /#{_name}/i).click

    @b.iframe(:name => 'ships').table(:index => 1).tr(:index =>2).td(:index => 0).when_present.click 
    
    @b.iframe(:name => 'ships').link(:onclick => "transferForm(\"#{notice}\")").when_present.click
    
    if (notice == "10")
      @b.iframe(:name => 'ships').text_field(:id => "BunkerOilHardEnt#{notice}").set fo_arrival
      @b.iframe(:name => 'ships').text_field(:id => "BunkerOilDieselEnt#{notice}").set go_arrival
      @b.iframe(:name => 'ships').text_field(:id => "BunkerOilGasEnt#{notice}").set "0.00"
    end

    if (notice == "_")
      departure_ts =~ /^([\d.\/]+) ([\d.]+):([\d.]+)/i
      departure_date = $1
      departure_hour = $2
      departure_min = $3
      
      @b.iframe(:name => 'ships').text_field(:id => "DateExit#{notice}").set departure_date
      @b.iframe(:name => 'ships').text_field(:id => "ExitHours#{notice}").set departure_hour
      @b.iframe(:name => 'ships').text_field(:id => "ExitMins#{notice}").set departure_min
      @b.iframe(:name => 'ships').text_field(:id => "DepositNose#{notice}").set _draft_departure
      @b.iframe(:name => 'ships').text_field(:id => "DepositStern#{notice}").set _draft_departure
      @b.iframe(:name => 'ships').text_field(:id => "BunkerOilHard#{notice}").set fo_departure
      @b.iframe(:name => 'ships').text_field(:id => "BunkerOilDiesel#{notice}").set go_departure
      @b.iframe(:name => 'ships').text_field(:id => "BunkerOilGas#{notice}").set "0.00"
      @b.iframe(:name => 'ships').checkbox(:id => "noCargo#{notice}").clear
      @b.iframe(:name => 'ships').link(:href => "javascript:void(0);addCargo(\'#{notice}\','frmExit')").click
      @b.iframe(:name => 'ships').select_list(:id => "CargoName#{notice}2").select   @b.iframe(:name => 'ships').select_list(:id => "CargoNameLoad#{notice}1").selected_options.map(&:text)[0] #value
      
      #if there is bl quantity in .quest.yml add bl quality otherwise fill previous value
      if (bl_figure)
        @b.iframe(:name => 'ships').text_field(:id => "CargoCount#{notice}2").set bl_figure
      else
        @b.iframe(:name => 'ships').text_field(:id => "CargoCount#{notice}2").set @b.iframe(:name => 'ships').text_field(:id => "CargoCountLoad#{notice}1").value
      end
    end
  end
  
  def fill_data

    puts "bunkers #{_bunkers_on_arrival}"
    fo_arrival, go_arrival = _bunkers_on_arrival.match(/^([\d.]+) \/ ([\d.]+)/i).captures

    arrival_ts =~ /^([\d.\/]+) ([\d.]+):([\d.]+)/i
    arrival_date = $1
    arrival_hour = $2
    arrival_min = $3

    departure_ts =~ /^([\d.\/]+) ([\d.]+):([\d.]+)/i
    departure_date = $1
    departure_hour = $2
    departure_min = $3

    _bunkers_departure_last =~ /^([\d.]+) \/ ([\d.]+)/i
    fo_departure_last = $1
    go_departure_last = $2

    @b.iframe(:name => 'ships').text_field(:id => "DatePrevPort#{notice}").set last_departure_date
    @b.iframe(:name => 'ships').text_field(:id => "DatePrevPortHours#{notice}").set '12'
    @b.iframe(:name => 'ships').text_field(:id => "DatePrevPortMins#{notice}").set '00'
    @b.iframe(:name => 'ships').select_list(:id => "CountryFollowing#{notice}").select "ITALY-IT"
    @b.iframe(:name => 'ships').select_list(:id => "PortFollowing#{notice}").select 'Augusta-ITAUG'
    @b.iframe(:name => 'ships').text_field(:id => "DateEnter#{notice}").set arrival_date
    @b.iframe(:name => 'ships').text_field(:id => "EnterHours#{notice}").set arrival_hour
    @b.iframe(:name => 'ships').text_field(:id => "EnterMins#{notice}").set arrival_min
    @b.iframe(:name => 'ships').text_field(:id => "DateExitP#{notice}").set departure_date
    @b.iframe(:name => 'ships').text_field(:id => "ExitHoursP#{notice}").set departure_hour
    @b.iframe(:name => 'ships').text_field(:id => "ExitMinsP#{notice}").set departure_min
    @b.iframe(:name => 'ships').text_field(:id => "AreaNavigation#{notice}").set "Worldwide"

    if (digest == "cpc")
      @b.iframe(:name => 'ships').text_field(:id => "PlaceRegistration#{notice}").set "KTK"
    end
    
    if (digest == "novo")
      @b.iframe(:name => 'ships').text_field(:id => "PlaceRegistration#{notice}").set "НМТП, Шесхарис"
    end
    
    @b.iframe(:name => 'ships').text_field(:id => "AreaNavigation#{notice}").set "Worldwide"
    
    @b.iframe(:name => 'ships').text_field(:id => "DepositNose#{notice}").set _draft_arrival_fore
    @b.iframe(:name => 'ships').text_field(:id => "DepositStern#{notice}").set _draft_arrival_aft

    #22a,b,v
    @b.iframe(:name => 'ships').text_field(:id => "DepositMax#{notice}").set _summer_draft
    @b.iframe(:name => 'ships').text_field(:id => "SurfaceDimension#{notice}").set _air_draft
    @b.iframe(:name => 'ships').text_field(:id => "BoardHeight#{notice}").set _m_depth

    if (digest == "cpc")
      @b.iframe(:name => 'ships').text_field(:id => "Terminal#{notice}").set "KTK"
      @b.iframe(:name => 'ships').text_field(:id => "Prichal#{notice}").set "ВПУ-1"
    end

    if (digest == "novo")
      @b.iframe(:name => 'ships').text_field(:id => "Terminal#{notice}").set "НМТП, Шесхарис"
      @b.iframe(:name => 'ships').text_field(:id => "Prichal#{notice}").set "1/1a"
    end

    if (digest == "taman")
      @b.iframe(:name => 'ships').text_field(:id => "Terminal#{notice}").set "TNG/Oteko"
      @b.iframe(:name => 'ships').text_field(:id => "Prichal#{notice}").set "5/6"
    end
    
    @b.iframe(:name => 'ships').radio(:id => "BallastYes#{notice}").set
    @b.iframe(:name => 'ships').text_field(:id => "BallastVolume#{notice}").set _ballast
    @b.iframe(:name => 'ships').text_field(:id => "BallastArea#{notice}").set 'Black Sea'
    @b.iframe(:name => 'ships').text_field(:id => "CrewCount#{notice}").set _crew_number
    @b.iframe(:name => 'ships').text_field(:id => "PassangerCount#{notice}").set _passenger_number
    @b.iframe(:name => 'ships').checkbox(:id => "noCargo#{notice}").set
    @b.iframe(:name => 'ships').text_field(:id => "ProductWastes#{notice}").set 'нет'
    @b.iframe(:name => 'ships').text_field(:id => "ShipStocks#{notice}").set "пищевые отходы 0.5 м3 \nбытовой мусор 1 м3"
    @b.iframe(:name => 'ships').text_field(:id => "CrewChange#{notice}").set 'нет'
    @b.iframe(:name => 'ships').select_list(:id => "ClassCode#{notice}").select 'Other-999'
    @b.iframe(:name => 'ships').text_field(:id => "OtherClass#{notice}").set _issc_class
    @b.iframe(:name => 'ships').text_field(:id => "DateCertIssue#{notice}").set _issc_issued
    @b.iframe(:name => 'ships').text_field(:id => "DateCertExpire#{notice}").set _issc_valid
    @b.iframe(:name => 'ships').select_list(:id => "ProtectionLevel#{notice}").select 'уровень 1'
    @b.iframe(:name => 'ships').text_field(:id => "Epidemi#{notice}").set 'all good'
    @b.iframe(:name => 'ships').text_field(:id => "NeedForEmerg#{notice}").set 'лоцман, буксиры'
    @b.iframe(:name => 'ships').text_field(:id => "BunkerOilHard#{notice}").set fo_departure_last
    @b.iframe(:name => 'ships').text_field(:id => "BunkerOilDiesel#{notice}").set go_departure_last
    @b.iframe(:name => 'ships').text_field(:id => "BunkerOilGas#{notice}").set '0.00'

    if (notice == "10")
      @b.iframe(:name => 'ships').text_field(:id => "BunkerOilHardEnt#{notice}").set fo_arrival
      @b.iframe(:name => 'ships').text_field(:id => "BunkerOilDieselEnt#{notice}").set go_arrival
      @b.iframe(:name => 'ships').text_field(:id => "BunkerOilGasEnt#{notice}").set "0.00"
    end
  end

end

notice = ARGV[0]
b = Portcall.new notice
b.login
sleep 1000

