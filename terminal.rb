# coding: utf-8
require 'yaml'

module Terminals

  raw_terminals = File.read('terminal.yaml')
  TERMINALS = YAML.load(raw_terminals)

  def terminal(t)
    TERMINALS[t]
  end

end

class Portcall
  include Terminals

  def initialize (*args)
    @berth, @wording, @name = *args
    @t, @b, @g = @berth.match(/([a-z][a-z]*)(\d\d?)(\w*)$/).captures
  end

  terminal_attributes = [ :manager, :where, :fax ]

  berth_attributes = [ :grade, :quantity, :rate, :manifold_number, :rate_per_manifold ]

  terminal_attributes.each do |ta|
    define_method(ta.to_s) do
      terminal(@t.to_sym)[ta]
    end
  end

  berth_attributes.each do |ba|
    define_method(ba.to_s) do
      terminal(@t.to_sym)["b#{@b}".to_sym][@g.to_sym][ba]
    end
  end

end

require 'test/unit'

class TestMyClass < Test::Unit::TestCase
  def test_can_include_shs_terminal
    p = Portcall.new("s6f", "n0001", "fram")

    assert_instance_of Hash, p.terminal(:s)
    assert_equal p.where, "Нефтерайон Шесхарис"
    assert_equal p.fax, "602062"
    assert_equal p.grade, "мазута"
  end

  def test_can_include_ipp_terminal
    p1 = Portcall.new("i26g", "n0001", "fram")

    assert_instance_of Hash, p1.terminal(:i)
    assert_equal p1.where, "Комбинат Импортпищепром"
    assert_equal p1.fax, "760138"
    assert_equal p1.grade, "диз.топлива"
  end
end
