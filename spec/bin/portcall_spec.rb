# coding: utf-8
require 'spec_helper'
require_relative '../../bin/portcall.rb'

describe Portcall do

  let!(:browser) { Portcall.new }

  it "has hash set" do
    p Dir.pwd
    expect(Portcall.new("72")._bunker_on_arrival).to eq "295.0 / 522.8"
  end

  context "new notice a nutshel" do

    before(:each) do
      browser.login
    end

    it "can login" do
      expect(browser.text.include?("almar")).to be_true
    end

    it "can acces browser via instance_variable_get" do
      expect(browser.instance_variable_get(:@b).url).to eq "https://portcall.marinet.ru/index.php"
      browser.instance_variable_get(:@b).iframes.find_all.each do |d|
        p d.id
      end

      browser.instance_variable_get(:@b).elements(:css => 'h2').each do |e|
        p e.id
      end
    end

    it "can supply new 72-hour notice" do
      browser.choose_action("72")
      puts "here:"
      expect(browser.instance_variable_get(:@b).url).to eq "https://portcall.marinet.ru/index.php"
      expect(browser.instance_variable_get(:@b).title).to eq "Судозаходы в морские порты РФ"
    end

    it "has browser object with iframe" do
      puts browser.instance_variable_get(:@b).iframe(:name => 'enter').text_field(:id => "CargoCountLoad#{notice}1").value
      puts "here #{browser.instance_variable_get(:@b)}"
      expect(browser.b.iframe(:name => 'enter')).to be_truthy
    end
  end

end
