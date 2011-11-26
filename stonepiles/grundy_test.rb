require 'test/unit'
require './grundy'

class ArrayTest < Test::Unit::TestCase
  def test_mex
    assert_equal 0, [3,2,1].mex
    assert_equal 1, [3,2,0].mex
    assert_equal 2, [3,1,0].mex
    assert_equal 3, [2,1,0].mex
  end
end

class IntegerTest < Test::Unit::TestCase
  def test_grundy_moves
    assert_equal [], 1.grundy_moves
    assert_equal [], 2.grundy_moves
    assert_equal [[1,2]], 3.grundy_moves
    assert_equal [[1,3]], 4.grundy_moves
    assert_equal [[1,4],[2,3]], 5.grundy_moves
    assert_equal [[1,5],[2,4]], 6.grundy_moves
    assert_equal [[1,6],[2,5],[3,4]], 7.grundy_moves
  end
end
