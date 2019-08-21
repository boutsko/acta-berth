# coding: utf-8
require 'spec_helper'
require 'berth'

describe Order do

  let(:berth2) { Order.new("s2c", "p2200", "Fram") }
  
  context "terminal Sheskharis" do

    it "loads config" do
      expect(APP_CONFIG[:agency][:name] ).to eq "Almar Services"
    end

    it "has takes _name from .quest.yml " do
      expect(berth2.name).to eq "SUVOROVSKY PROSPECT"
    end
    
    it "generates appointment" do

      expect(berth2.digest).to eq "s1co"
      expect(berth2).to_not be_nil
      expect(berth2.manager).to eq "Жевец М.Г."
    end

    it "generates arrival" do
      berth = Order.new("s2c", "a2200", "Fram")
      expect(berth).to_not be_nil
      expect(berth.where).to eq "Нефтерайон Шесхарис" 
      expect(berth.rate).to eq("6,000")
      expect(berth.grade).to eq "сырой нефти"          
    end

    it "generates notice_of_readiness" do
      berth = Order.new("s2c", "n0001", "Fram")
      expect(berth).to_not be_nil
    end

    it "generates vessel's info" do
      berth = Order.new("s2c", "ishs", "Fram")
      expect(berth).to_not be_nil
    end

    it "generates rate_guarantee" do
      berth = Order.new("s2c", "r", "Fram")
      expect(berth).to_not be_nil
    end

    it "generates pilot_order" do
      berth = Order.new("s2c", "l30121800:31122100m1")
      expect(berth).to_not be_nil
    end

    it "generates tugs_order" do
      berth = Order.new("s2c", "t30121800:31122100m1")
      expect(berth).to_not be_nil
    end
  end


  context "terminal IPP" do
    it "generates appointment" do
      berth = Order.new("i26g", "p2200", "Fram")
      expect(berth).to_not be_nil
    end

    it "generates arrival" do
      berth = Order.new("i26g", "a2200", "Fram")
      expect(berth).to_not be_nil
    end

    it "generates notice_on_arrival" do
      berth = Order.new("i26g", "N2200", "Fram")
      expect(berth).to_not be_nil
    end
    
    it "generates notice_of_readiness" do
      berth = Order.new("i26g", "n0001", "Fram")
      expect(berth).to_not be_nil
    end

    it "generates vessel's info" do
      berth = Order.new("i26g", "iipp", "Fram")
      expect(berth).to_not be_nil
    end

    it "generates pilot_order" do
      berth = Order.new("i26go", "l30121800:31122100m1")
      expect(berth).to_not be_nil
    end

    it "generates tugs_order" do
      berth = Order.new("i26go", "t30121800:31122100m1")
      expect(berth).to_not be_nil
    end
  end

end
