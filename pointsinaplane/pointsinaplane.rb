class Point
  attr_reader :x
  attr_reader :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def slope(point)
    Rational(point.y - @y, point.x - @x)
  end

  def ==(point)
    @x == point.x and @y == point.y
  end
end

class Plane
  def initialize
    @points = []
  end

  def add_point(x, y)
    @points.push Point.new(x,y)
  end

  def minimum_moves
    @points.each do |i|
      @points.each do |j|
        if i != j

        end
      end
    end
  end
end

if $0 == __FILE__
  mod = 1000000007

  t = Integer(ARGF.readline)
  t.times do
    plane = Plane.new

    n = Integer(ARGF.readline)
    n.times do
      x,y = ARGF.readline.split.map {|a| Integer(a)}
      plane.add_point x,y
    end

    #Figure out how many ways to remove points in minimal moves
  end
end
