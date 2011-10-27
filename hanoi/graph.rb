class Array
  def are_all_same?
    return false if empty?
    count(first) == size
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

class Vertex
  attr_reader :state
  
  def initialize(*state)
    @state = state
  end
  
  def [](index)
    @state[index-1]
  end
  
  def to_s
    return @state.join(" ")
  end
  
  def move(vertex)
    raise "expected length #{@state.length} but was #{vertex.state.length}" if @state.length != vertex.state.length
    @state.zip(vertex.state).select { |pair| !pair.are_all_same? }.first
  end
end

class HanoiGraph
  attr_reader :vertices
  attr_reader :edges

  def initialize(discs)
    if discs == 1
      @vertices = [
        Vertex.new(1),
        Vertex.new(2),
        Vertex.new(3)
      ]
      @edges = {
        "1" => [2,3],
        "2" => [1,3],
        "3" => [1,2]
      }
    else
      raise "Not Implemented"
    end
    
    @lookup = {}
    @vertices.each_with_index do |vertex, i|
      @lookup[vertex.to_s] = i
    end
  end
  
  def shortest_path(from, to)
    path = {}
    visited = {from => true}
    queue = [from]

    while queue.length > 0 and current = queue.pop and current != to
      @edges[current].each do |a|
        key = @vertices[a-1].to_s
        if !visited[key]
          visited[key] = true
          queue.unshift(key)
          path[key] = from
        end
      end
    end

    moves = []
    rewind = to
    while path[rewind] != nil
      v1 = @vertices[@lookup[path[rewind]]]
      v2 = @vertices[@lookup[rewind]]
      moves.push(v1.move(v2))
      rewind = path[rewind]
    end 
    moves.reverse()
  end
end