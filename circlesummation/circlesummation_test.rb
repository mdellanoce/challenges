require 'test/unit'
require './circlesummation'

class CircleSummationTest < Test::Unit::TestCase
  def test_circle_sum_given1
    seed = [10,20,30,40,50]
    assert_equal [80,20,30,40,50], seed.circle_sum(0, 1)
    assert_equal [10,60,30,40,50], seed.circle_sum(1, 1)
    assert_equal [10,20,90,40,50], seed.circle_sum(2, 1)
    assert_equal [10,20,30,120,50], seed.circle_sum(3, 1)
    assert_equal [10,20,30,40,100], seed.circle_sum(4, 1)
  end
  
  def test_circle_sum_given2
    seed = [1,2,1]
    assert_equal [4,2,1], seed.circle_sum(0, 1)
    assert_equal [4,7,1], seed.circle_sum(0, 2)
    assert_equal [4,7,12], seed.circle_sum(0, 3)
    assert_equal [23,7,12], seed.circle_sum(0, 4)
    
    assert_equal [1,4,1], seed.circle_sum(1, 1)
    assert_equal [1,4,6], seed.circle_sum(1, 2)
    assert_equal [11,4,6], seed.circle_sum(1, 3)
    assert_equal [11,21,6], seed.circle_sum(1, 4)
    
    assert_equal [1,2,4], seed.circle_sum(2, 1)
    assert_equal [7,2,4], seed.circle_sum(2, 2)
    assert_equal [7,13,4], seed.circle_sum(2, 3)
    assert_equal [7,13,24], seed.circle_sum(2, 4)
  end
end