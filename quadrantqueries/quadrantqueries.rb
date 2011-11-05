class Plane
  def initialize
    @points = []
  end

  def add_point(x, y)
    @points.push [x,y]
  end

  def reflect_x(i, j)
    (i-1).upto(j-1) do |p|
      @points[p][1] = -@points[p][1]
    end
  end

  def reflect_y(i, j)
    (i-1).upto(j-1) do |p|
      @points[p][0] = -@points[p][0]
    end
  end

  def count(i, j)
    c = [0,0,0,0]
    (i-1).upto(j-1) do |p|
      point = @points[p]
      c[0]+=1 if point[0] > 0 and point[1] > 0
      c[1]+=1 if point[0] < 0 and point[1] > 0
      c[2]+=1 if point[0] < 0 and point[1] < 0
      c[3]+=1 if point[0] > 0 and point[1] < 0
    end
    c
  end
end

if __FILE__ == $0
  plane = Plane.new

  points = Integer(ARGF.readline)
  points.times do
    x, y = ARGF.readline.split.map {|i| Integer(i)}
    plane.add_point x, y
  end

  queries = Integer(ARGF.readline)
  queries.times do
    command, i, j = ARGF.readline.split
    i = Integer(i)
    j = Integer(j)

    if command == "C"
      puts plane.count(i, j).join(" ")
    elsif command == "X"
      plane.reflect_x i, j
    elsif command == "Y"
      plane.reflect_y i, j
    end
  end
end
