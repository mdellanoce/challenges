require 'test/unit'
require './reduce'

class ReduceTest < Test::Unit::TestCase
  def test_reduce
    reducer = Reducer.new
    assert_equal 2, reducer.reduce("cab")
    assert_equal 1, reducer.reduce("bcab")
    assert_equal 5, reducer.reduce("ccccc")
    assert_equal 1, reducer.reduce("abcabcabacabcabacabaabccababacabacacababa")
    assert_equal 2, reducer.reduce("abcabcabacabcabacabaabccababacabacacababaabcabcabacabcabacabaabccababacabacacababa")
  end
end