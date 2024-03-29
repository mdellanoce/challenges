require 'test/unit'
require './permutationgame'

class ArrayTest < Test::Unit::TestCase
  def test_longest
    assert_equal [4,2], [1,2,3,6,5].longest
    assert_equal [2,3], [4,3,1,2].longest
  end
end

class PositionTest < Test::Unit::TestCase
  def test_is_increasing
    assert Position.new([3]).is_increasing?
    assert Position.new([1,2,3,4]).is_increasing?
    assert !Position.new([2,1,3,4,5]).is_increasing?
  end

  def test_is_decreasing
    assert Position.new([4,3,2,1]).is_decreasing?
    assert !Position.new([2,1,3,4,5]).is_decreasing?
    assert !Position.new([3]).is_decreasing?
  end

  def test_is_winning
    assert Position.new([1,2,3,4]).is_winning?
    assert Position.new([4,3,2]).is_winning?
    assert !Position.new([1,3,2]).is_winning?
  end

  def test_is_losing
    assert Position.new([4,3,2,1]).is_losing?
    assert !Position.new([1,3,2]).is_losing?
  end

  def test_remaining_moves
    p = Position.new [4,3,2,1]
    assert_equal 3, p.remaining_moves
  end

  def test_next_positions
    p = Position.new [1,3,2,4]
    next_positions = p.next_positions.map {|x| x.to_s}.to_a
    assert_equal ["2 1 3", "1 2 3", "1 2 3", "1 3 2"], next_positions

    p = Position.new [1,2,3,4]
    next_positions = p.next_positions.map {|x| x.to_s}.to_a
    assert_equal [], next_positions
  end
end
