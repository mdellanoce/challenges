require 'test/unit'
require './graph'

class HanoiStateTest < Test::Unit::TestCase
  def test_state_equivalence
    s1 = HanoiState.new 3, [1,1,2]
    s2 = HanoiState.new 3, [1,1,2]
    s3 = HanoiState.new 4, [1,1,2,2]

    assert s1 == s2
    assert s2 != s3
  end

  def test_three_pegs_two_discs_legal_moves
    s = HanoiState.new 3, [1,1]
    assert_equal [[1,2],[1,3]], s.legal_moves

    s = HanoiState.new 3, [2,1]
    assert_equal [[2,1],[2,3],[1,3]], s.legal_moves
  end

  def test_four_pegs_six_discs_legal_moves
    s = HanoiState.new 4, [4,2,4,3,1,1]
    assert_equal [[4,1],[4,2],[4,3],[2,1],[2,3],[3,1]], s.legal_moves
  end

  def test_make_move
    s = HanoiState.new 3, [2,1]
    expected = HanoiState.new 3, [2,3]
    assert_equal expected, s.make_move([1,3])
  end

  def test_move
    s1 = HanoiState.new 3, [1,1]
    s2 = HanoiState.new 3, [2,1]

    assert_equal [1,2], s1.move(s2)
    assert_equal [2,1], s2.move(s1)
  end

  def test_three_pegs_two_discs_shortest_path
    from = HanoiState.new 3, [1,1]
    to = HanoiState.new 3, [2,2]
    moves = from.shortest_path to
    assert_equal [[1,3],[1,2],[3,2]], moves
  end

  def test_four_pegs_six_discs_shortest_path
    from = HanoiState.new 4, [4,2,4,3,1,1]
    to = HanoiState.new 4, [1,1,1,1,1,1]
    moves = from.shortest_path to
    assert_equal [[3,1],[4,3],[4,1],[2,1],[3,1]], moves
  end
end
