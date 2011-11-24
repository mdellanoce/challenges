require 'test/unit'
require './permutationgame'

class PositionTest < Test::Unit::TestCase
  def test_is_winning
    assert Position.new([1,2,3,4]).is_winning?
    assert !Position.new([2,1,3,4,5]).is_winning?
  end

  def test_next_positions
    p = Position.new [1,3,2,4]
    next_positions = p.next_positions.map {|x| x.to_s}.to_a
    assert_equal ["3 2 4", "1 2 4", "1 3 4", "1 3 2"], next_positions
  end
end
