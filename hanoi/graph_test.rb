require 'test/unit'
require './graph'

class ArrayTest < Test::Unit::TestCase
  def test_are_all_same
    assert ![].are_all_same?
    assert ![1,2,3].are_all_same?
    assert [1,1,1].are_all_same?
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
    
  def test_three_peg_two_discs
    g = HanoiGraph.new 2
    moves = g.shortest_path "1 1", "2 2"
    assert_equal [[1,3],[1,2],[3,2]], moves
  end
  
  def test_three_peg_three_discs
    g = HanoiGraph.new 3
    moves = g.shortest_path "1 1 1", "2 2 2"
    assert_equal [[1,2],[1,3],[2,3],[1,2],[3,1],[3,2],[1,2]], moves
  end
end

class StateTest < Test::Unit::TestCase
  def test_three_pegs_two_discs
    s = State.new 3, [1,1]
    assert_equal [[1,2],[1,3]], s.legal_moves

    s = State.new 3, [2,1]
    assert_equal [[2,1],[2,3],[1,3]], s.legal_moves
  end

  def test_four_pegs_six_discs
    s = State.new 4, [4,2,4,3,1,1]
    assert_equal [[4,1],[4,2],[4,3],[3,1],[2,1],[2,3]], s.legal_moves
  end
end
