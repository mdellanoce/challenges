require 'test/unit'
require './graph'

class StateTest < Test::Unit::TestCase
  def test_state_equivalence
    s1 = State.new 3, [1,1,2]
    s2 = State.new 3, [1,1,2]
    s3 = State.new 4, [1,1,2,2]

    assert s1 == s2
    assert s2 != s3
  end

  def test_three_pegs_two_discs_legal_moves
    s = State.new 3, [1,1]
    assert_equal [[1,2],[1,3]], s.legal_moves

    s = State.new 3, [2,1]
    assert_equal [[2,1],[2,3],[1,3]], s.legal_moves
  end

  def test_four_pegs_six_discs_legal_moves
    s = State.new 4, [4,2,4,3,1,1]
    assert_equal [[4,1],[4,2],[4,3],[2,1],[2,3],[3,1]], s.legal_moves
  end
end
