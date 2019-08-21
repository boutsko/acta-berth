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
    @b = Watir::Browser.new
  end

  def notice
    @notice
  end

  def login
    @b.goto 'portcall.marinet.ru'
    @b.text_field(:name => 'login').set 'almar'
    @b.text_field(:name => 'password').set '4225c4a5'
    @b.link(:text =>"Вход").click

    find_from_existing
  end

  def find_from_existing

    @b.iframe(:name => 'enter').td(:text => /#{_name}/i).click
    # /html/body/div/table[2]/tbody/tr[3]/td[1] - recent change
    @b.iframe(:name => 'ships').table(:index => 1).tr(:index =>2).td(:index => 0).when_present.click

    @b.iframe(:name => 'ships').button(:class => "btn btn-danger", :text => "Загрузить документы").when_present.click
    Watir::HTMLElement.attributes << :key2

    certificates = {
      "01" => "register",
      "02" => "crew-list",
      "04" => "tonnage",
      "05" => "class",
      "06" => "load-line",
      "07" => "maritime-declaration-of-health",
      "08" => "ship-sanitation-control-exemption",
      "10" => "clc-oil",
      "11" => "clc-bunker",
      "12" => "iopp",
      "13" => "garbage-polution-prevention",
      "14" => "sewage-polution-prevention",
      "15" => "air-polution-prevention",
      "16" => "issc",
      "19" => "safety-construction",
      "20" => "safety-equipment",
      "21" => "safety-radio",
      "23" => "maritime-labour",
      "24" => "declaraion-maritime-labour",
      "25" => "safety-management",
      "31" => "document-of-compliance",
      "34" => "ballast-water-management"
    }

    certificates.each do |k, v|

      FileUtils.cp( "Certificates/#{k}.pdf", "/tmp/#{k}.pdf" )

      p "k = #{k}"

      @b.iframe(:name => 'ships').div(:class => "docBlock", :index => k.to_i - 1).file_field().set("/tmp/#{k}.pdf")
      @b.iframe(:name => 'ships').div(:class => "docBlock", :index => k.to_i - 1).button(:class => "btn btn-danger", :text => "Загрузить").when_present.click

      file_with_name_of_certificate = "#{k}-#{v}"
      File.rename( "Certificates/#{k}.pdf", "Certificates/#{file_with_name_of_certificate}.pdf" )
      p "rename #{k}.pdf to #{file_with_name_of_certificate}.pdf"
    end
  end

end

notice = ARGV[0]
b = Portcall.new notice
b.login
sleep 1000

