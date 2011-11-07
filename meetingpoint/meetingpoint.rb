class Point
	attr_reader :x
	attr_reader :y
	
	def initialize(x,y)
		@x = x
		@y = y
	end
	
	def distance_to(p)
		Math.sqrt((x-p.x)**2 + (y-p.y)**2)
	end
	
	def grid_distance_to(p)
		[(x-p.x).abs, (y-p.y).abs].max
	end
end

class Grid
	def add_point(p)
		@points ||= []
		@points.push p
	end
	
	def centroid
		s = @points.inject {|p,n| Point.new(p.x + n.x, p.y + n.y)}
		s = Point.new(Float(s.x)/@points.length, Float(s.y)/@points.length)
		@points.min_by {|p| s.distance_to p}
	end
	
	def minimum_travel_time
		c = centroid
		d = 0
		@points.each do |p|
			d+= c.grid_distance_to(p)
		end
		d
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