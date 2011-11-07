require 'test/unit'
require './circlesummation'

class CircleSummationTest < Test::Unit::TestCase
  def test_rotate
    assert_equal [2,3,1], [1,2,3].rotate
    assert_equal [3,1,2], [1,2,3].rotate(-1)
  end
  
  def test_circle_sum_given1
    seed = [10,20,30,40,50]
    assert_equal [[80,20,30,40,50],
                  [10,60,30,40,50],
                  [10,20,90,40,50],
                  [10,20,30,120,50],
                  [10,20,30,40,100]], seed.circle_sum_fast(1)
  end
  
  def test_circle_sum_given2
    seed = [1,2,1]
    assert_equal [[23,7,12],
                  [11,21,6],
                  [7,13,24]], seed.circle_sum_fast(4)
  end
end
