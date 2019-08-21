require 'spec_helper'
require_relative '../../bin/parse.rb'

describe Parser do

  let(:parser) { Parser.new }
  
  context "in a nutshel" do

    it "exists" do
      expect(parser.hello).to eq "this is parser"
    end
  end
end
