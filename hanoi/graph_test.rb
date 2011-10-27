require 'test/unit'
require './graph'

class ArrayTest < Test::Unit::TestCase
  def test_are_all_same
    assert ![].are_all_same?
    assert ![1,2,3].are_all_same?
    assert [1,1,1].are_all_same?
  end
  
  def test_rotate
    assert_equal [], [].rotate
    assert_equal [2,3,1], [1,2,3].rotate
    assert_equal [3,1,2], [1,2,3].rotate(-1)
  end
end

class VertexTest < Test::Unit::TestCase
  def test_hanoi_move
    v1 = Vertex.new(1,2,3)
    v2 = Vertex.new(1,2,2)
    
    move = v1.move v2
    assert_equal [3,2], move
    
    reverse_move = v2.move v1
    assert_equal [2,3], reverse_move
  end
  
  def test_hanoi_move_error
    assert_raise(RuntimeError) do
      Vertex.new(1,2).move Vertex.new(1)
    end
  end
end

class HanoiGraphTest < Test::Unit::TestCase
  def test_three_peg_one_disc
    g = HanoiGraph.new 1
    moves = g.shortest_path "1", "3"
    assert_equal [[1,3]], moves
  end
end