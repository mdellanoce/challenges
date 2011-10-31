require 'test/unit'
require './reduce'

class ReduceTest < Test::Unit::TestCase
  def test_reductions
    assert_equal ["bb","cc"], reductions("cab")
    assert_equal ["aab","bbb","bcc"], reductions("bcab")
    assert_equal [], reductions("ccccc")
  end
  
  def test_reduce
    assert_equal 2, reduce("cab")
    assert_equal 1, reduce("bcab")
    assert_equal 5, reduce("ccccc")
    assert_equal 1, reduce("abcabcabacabcabacabaabccababacabacacababa")
    assert_equal 1, reduce("abcabcabacabcabacabaabccababacabacacababaabcabcabacabcabacabaabccababacabacacababa")
  end
end
