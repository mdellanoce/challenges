require 'test/unit'
require './reduce'

class ReduceTest < Test::Unit::TestCase
  def test_reduce
    assert_equal "cc", reduce("cab")
    assert_equal "b", reduce("bcab")
    assert_equal "ccccc", reduce("ccccc")
  end
end