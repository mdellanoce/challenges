require 'test/unit'
require './equations'

class EquationsTest < Test::Unit::TestCase
  def test_given
    assert_equal 9, Equations.count_solutions(3)
    assert_equal 21, Equations.count_solutions(4)
    assert_equal 63, Equations.count_solutions(5)
    assert_equal 656502, Equations.count_solutions(32327)
    assert_equal 686720, Equations.count_solutions(40921)
  end
  
  def test_large
    Equations.count_solutions(10**6)
  end
end