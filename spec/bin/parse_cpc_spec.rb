# coding: utf-8
require 'spec_helper'
require_relative '../../bin/parse_cpc'

Parser.location = "cpc"

describe Parser do

  context 'terminal CPC' do

    it 'runs tests' do
      expect(1).to eq 1
    end
    
    it 'matches everything' do
      expect(Parser.method("everything").call("1.20")).to eq /^[-\s]*1.20.*?:(.*$)/
    end
    it 'matches text_line' do
      expect(Parser.method("text_line").call("1.20")).to eq /^[-\s]*1.20.*?:[ \s]*([-\w\d\/ ]+)/
    end
    it 'matches number_line' do
      expect(Parser.method("number_line").call("1.20")).to eq /^[-\s]*1.20.*?:([0-9.,]+)/
    end

    it 'finds everything-line' do
      yaml_line =  { _ballast: ["1.20", "everything"] }
      quest_line = "-1.20. QUANTITY OF BALLAST WATER ON ARRIVAL IN TONES AND PERSENT OF SDWT :31950 MT/33%" 
      yaml_line.each do |key, value|
        # p key
        # p value[1]
        quest_line.match(Parser.method(value[1]).call(value[0]))
        expect($1).to eq "31950 MT/33%"
      end
    end
    it 'finds text_line' do
      yaml_line =  { _ballast: ["1.20", "text_line"] }
      quest_line = "-1.20. QUANTITY OF BALLAST WATER ON ARRIVAL IN TONES AND PERSENT OF SDWT :31950 MT/33%" 
      yaml_line.each do |key, value|
        quest_line.match(Parser.method(value[1]).call(value[0]))
        expect($1).to eq "31950 MT/33"
      end
    end
    it 'finds number-line' do
      yaml_line =  { _ballast: ["1.20", "number_line"] }
      quest_line = "-1.20. QUANTITY OF BALLAST WATER ON ARRIVAL IN TONES AND PERSENT OF SDWT :31950 MT/33%" 
      yaml_line.each do |key, value|
        quest_line.match(Parser.method(value[1]).call(value[0]))
        expect($1).to eq "31950"
      end
    end
  end
end
