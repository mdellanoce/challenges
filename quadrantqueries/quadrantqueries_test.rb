require 'test/unit'
require './quadrantqueries.rb'

class PlaneTest < Test::Unit::TestCase
  def test_given
    plane = Plane.new
    plane.add_point 1,1
    plane.add_point -1,1
    plane.add_point -1,-1
    plane.add_point 1,-1

    assert_equal [1,1,1,1], plane.count(1,4)
    plane.reflect_x 2,4
    assert_equal [1,1,0,0], plane.count(3,4)
    plane.reflect_y 1,2
    assert_equal [0,2,0,1], plane.count(1,3)
  end

  def test_fast
    plane = FastPlane.new 4
    plane.add_point 1,1
    plane.add_point -1,1
    plane.add_point -1,-1
    plane.add_point 1,-1

    assert_equal [1,1,1,1], plane.count(1,4)
    plane.reflect_x 2,4
    assert_equal [1,1,0,0], plane.count(3,4)
  end
end
