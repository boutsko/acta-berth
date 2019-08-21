# coding: utf-8
require 'spec_helper'
require 'berth'

class Portcall
  extend Terminals

  def initialize (*args)
    @berth, @wording, @name = *args
    @t, @b, @g = @berth.match(/([a-z][a-z]*)(\d\d?)(\w*)$/).captures
    Portcall.set_methods(@t, @b, @g)
  end

end

require 'test/unit'

class TestMyClass < Test::Unit::TestCase
  def test_can_include_shs_terminal
    p = Portcall.new("s6f", "n0001", "fram")

    assert_instance_of Hash, Terminals::TERMINALS[:s]
    assert_equal p.where, "Нефтерайон Шесхарис"
    assert_equal p.fax, "602062"
    assert_equal p.grade, "мазута"
  end

  def test_can_include_ipp_terminal
    p1 = Portcall.new("i26g", "n0001", "fram")

    assert_instance_of Hash, Terminals::TERMINALS[:i]
    assert_equal p1.where, "Комбинат Импортпищепром"
    assert_equal p1.fax, "760138"
    assert_equal p1.grade, "диз.топлива"
  end

end
