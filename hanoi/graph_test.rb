require 'test/unit'
require 'graph'

class ArrayTest < Test::Unit::TestCase
  def test_perfect
    assert ![].perfect?
    assert ![1,2,3].perfect?
    assert [1,1,1].perfect?
  end
  
  def test_hanoi_move
    move = [1,2,3].hanoi_move [1,2,2]
    assert_equal [3,2], move
    
    reverse_move = [1,2,2].hanoi_move [1,2,3]
    assert_equal [2,3], reverse_move
  end
  
  def test_hanoi_move_error
    assert_raise(RuntimeError) do
      [1,2].hanoi_move [1]
    end
  end
  
  def test_rotate
    assert_equal [], [].rotate
    assert_equal [2,3,1], [1,2,3].rotate
    assert_equal [3,1,2], [1,2,3].rotate(-1)
  end
end