require 'test/unit'
require './meetingpoint'

class MeetingPointTest < Test::Unit::TestCase
	def test_given
		g = Grid.new
		g.add_point Point.new(0,1)
		g.add_point Point.new(2,5)
		g.add_point Point.new(3,1)
		g.add_point Point.new(4,0)
		assert_equal 8, g.minimum_travel_time
	end
	
	def test_diagonals
		g = Grid.new
		g.add_point Point.new(1,1)
		g.add_point Point.new(4,4)
		g.add_point Point.new(7,7)
		g.add_point Point.new(1,7)
		assert_equal 9, g.minimum_travel_time
	end
end