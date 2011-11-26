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
