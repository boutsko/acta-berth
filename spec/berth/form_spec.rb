# coding: utf-8
require 'spec_helper'
require_relative '../../lib/berth/form'
require_relative '../../lib/berth/monkey_string'

class String
  include MonkeyString
end


describe Form do
  class DummyClass
    attr_accessor :wording, :name, :subject, :content
    include Form

    def create_pdf(subject, content)
      content
    end
  end

  before(:each) do
    including_class.wording = "A2200"
    including_class.name = "Fram"
    including_class.subject = "SUBJ"
    including_class.content = "CONT"
  end

  let(:including_class) { DummyClass.new }
  
  it "works" do
    expect(including_class.choose_form).to eq "Пожалуйста, примите к сведению, что данный танкер прибывает в Новороссийск 15/04/22:00."
    expect(including_class.choose_form).to be_truthy
  end
end
