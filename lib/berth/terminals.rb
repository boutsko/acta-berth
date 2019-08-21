# coding: utf-8
require 'yaml'
require_relative 'utils'

module Terminals

  terminals_yaml_file = Foobar::Utils.gem_libdir + '/yamls/terminals.yaml'

  raw_terminals = File.read(terminals_yaml_file)
  TERMINALS = YAML.load(raw_terminals)

  def set_methods(terminal, berth, grade) 

    terminal_attributes = [ :manager, :where, :fax ]
    berth_attributes = [ :grade, :quantity, :rate, :manifold_number, :rate_per_manifold ]

    terminal_attributes.each do |ta|
      define_method(ta.to_s) do
        TERMINALS[terminal.to_sym][ta]
      end
    end

    berth_attributes.each do |ba|
      define_method(ba.to_s) do
        TERMINALS[terminal.to_sym]["b#{berth}".to_sym][grade.to_sym][ba]
      end
    end
  end  
end

# testing :
# class Portcall
#   extend Terminals

#   def initialize (*args)
#     @berth, @wording, @name = *args
#     @t, @b, @g = @berth.match(/([a-z][a-z]*)(\d\d?)(\w*)$/).captures
#     Portcall.set_methods(@t, @b, @g)    
#   end
  
# end

# require 'test/unit'

# class TestMyClass < Test::Unit::TestCase
#   def test_can_include_shs_terminal
#     p = Portcall.new("s6f", "n0001", "fram")

#     assert_instance_of Hash, Terminals::TERMINALS[:s]
#     assert_equal p.where, "Нефтерайон Шесхарис"
#     assert_equal p.fax, "602062"
#     assert_equal p.grade, "мазута"
#   end

#   def test_can_include_ipp_terminal
#     p1 = Portcall.new("i26g", "n0001", "fram")

#     assert_instance_of Hash, Terminals::TERMINALS[:i]
#     assert_equal p1.where, "Комбинат Импортпищепром"
#     assert_equal p1.fax, "760138"
#     assert_equal p1.grade, "диз.топлива"
#   end
# end
