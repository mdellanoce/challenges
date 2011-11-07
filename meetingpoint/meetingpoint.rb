class Point
	attr_reader :x
	attr_reader :y
	
	def initialize(x,y)
		@x = x
		@y = y
	end
	
	def distance_to(p)
		Math.sqrt((x-p.x)**2 + (y-p.y)**2).to_i
	end
end

class Grid
	def add_point(p)
		@points ||= []
		@points.push p
	end
	
	def centroid
		s = @points.inject {|p,n| Point.new(p.x + n.x, p.y + n.y)}
		Point.new(s.x/@points.length, s.y/@points.length)
	end
	
	def minimum_travel_time
		0
	end
end

if __FILE__ == $0
	grid = Grid.new
	
	num_points = Integer(ARGF.readline)
	num_points.times do
		x,y = ARGF.readline.split.map {|p| Integer(p)}
		grid.add_point Point.new(x,y)
	end
	
	puts grid.minimum_travel_time
end