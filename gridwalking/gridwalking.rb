class Grid
  def initialize(dimensions)
    @dimensions = dimensions
  end

  def count_ways(position, steps)
    next_positions = possible_steps(position)
    if steps == 1
      next_positions.length
    else
      next_positions.map do |p|
        count_ways(p, steps-1)
      end.inject(:+)
    end
  end

  protected

  def possible_steps(position)
    steps = []
    position.each_with_index do |p, i|
      if p < @dimensions[i]
        s = position.dup
        s[i] += 1
        steps.push s
      end
    end
    position.each_with_index do |p, i|
      if p > 0
        s = position.dup
        s[i] -= 1
        steps.push s
      end
    end
    steps
  end
end

if $0 == __FILE__
  t = Integer(ARGF.readline)
  t.times do
    d, steps = ARGF.readline.split.map {|i| Integer(i)}
    position = ARGF.readline.split.map {|i| Integer(i)}.to_a
    dimensions = ARGF.readline.split.map {|i| Integer(i)}.to_a

    g = Grid.new dimensions
    puts g.count_ways(position, steps) % 1000000007
  end
end
