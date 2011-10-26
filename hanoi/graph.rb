class Vertex
  attr_reader :state
  attr_reader :adjacent

  def initialize(*state)
    @state = state
    @adjacent = []
  end
  
  def add_adjacent(vertex)
    @adjacent.push(vertex)
    vertex.adjacent.push(self)
    self
  end
  
  def to_s
    @state.join
  end
  
  def each(&block)
    visited = {self.to_s => true}
    queue = [self]
    
    while queue.length > 0
      current = queue.pop
      block.call(current)
      current.adjacent.each do |a|
        key = a.to_s
        if !visited[key]
          visited[key] = true
          queue.unshift(a)
        end
      end
    end
  end
end

class Array
  def perfect?
    return false if empty?
    count(first) == size
  end
  
  def hanoi_move(other_array)
    raise "expected length #{length} but was #{other_array.length}" if length != other_array.length
    zip(other_array).select { |pair| !pair.perfect? }.first
  end
  
  def rotate(n=1)
    dup.rotate!(n)
  end unless method_defined? :rotate
  
  def rotate!(n=1)
    return self if empty?
    n %= size
    concat(slice!(0, n))
  end unless method_defined? :rotate!
end

def hanoi_graph(discs)
  #How to generalize for N pegs?
  if discs == 1
    a = Vertex.new(1)
    b = Vertex.new(2)
    c = Vertex.new(3)
    a.add_adjacent(b)
    b.add_adjacent(c)
    c.add_adjacent(a)
    a
  else
    raise "not implemented"
  end
end

x = hanoi_graph(1)
x.each {|a| puts a}