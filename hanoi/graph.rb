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
    elsif discs == 2
      @vertices = [
        Vertex.new(1,1),
        Vertex.new(2,1),
        Vertex.new(3,1),
        Vertex.new(1,2),
        Vertex.new(2,2),
        Vertex.new(3,2),
        Vertex.new(1,3),
        Vertex.new(2,3),
        Vertex.new(3,3)
      ]
      @edges = {
        "1 1" => [2,3],
        "2 1" => [1,3,8],
        "3 1" => [1,2,6],
        "1 2" => [5,6,7],
        "2 2" => [4,6],
        "3 2" => [4,5,3],
        "1 3" => [8,9,4],
        "2 3" => [7,9,2],
        "3 3" => [7,8]
      }
    elsif discs == 3
      @vertices = [
        Vertex.new(1,1,1),
        Vertex.new(2,1,1),
        Vertex.new(3,1,1),
        Vertex.new(1,2,1),
        Vertex.new(2,2,1),
        Vertex.new(3,2,1),
        Vertex.new(1,3,1),
        Vertex.new(2,3,1),
        Vertex.new(3,3,1),
        
        Vertex.new(1,1,2),
        Vertex.new(2,1,2),
        Vertex.new(3,1,2),
        Vertex.new(1,2,2),
        Vertex.new(2,2,2),
        Vertex.new(3,2,2),
        Vertex.new(1,3,2),
        Vertex.new(2,3,2),
        Vertex.new(3,3,2),
        
        Vertex.new(1,1,3),
        Vertex.new(2,1,3),
        Vertex.new(3,1,3),
        Vertex.new(1,2,3),
        Vertex.new(2,2,3),
        Vertex.new(3,2,3),
        Vertex.new(1,3,3),
        Vertex.new(2,3,3),
        Vertex.new(3,3,3)
      ]
      @edges = {
        "1 1 1" => [2,3],
        "2 1 1" => [1,3,8],
        "3 1 1" => [1,2,6],
        "1 2 1" => [5,6,7],
        "2 2 1" => [4,6,23],
        "3 2 1" => [4,5,3],
        "1 3 1" => [8,9,4],
        "2 3 1" => [7,9,2],
        "3 3 1" => [7,8,18],
        
        "1 1 2" => [11,12,19],
        "2 1 2" => [10,12,17],
        "3 1 2" => [10,11,15],
        "1 2 2" => [14,15,16],
        "2 2 2" => [13,15],
        "3 2 2" => [13,14,12],
        "1 3 2" => [17,18,13],
        "2 3 2" => [16,18,11],
        "3 3 2" => [16,17,9],
        
        "1 1 3" => [20,21,10],
        "2 1 3" => [19,21,26],
        "3 1 3" => [19,20,24],
        "1 2 3" => [23,24,25],
        "2 2 3" => [22,24,5],
        "3 2 3" => [22,23,21],
        "1 3 3" => [26,27,22],
        "2 3 3" => [25,27,20],
        "3 3 3" => [25,26]
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
          path[key] = current
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
    raise "Path from #{from} to #{to} not found" if moves.empty?
    moves.reverse()
  end
end