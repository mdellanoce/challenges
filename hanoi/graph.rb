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

class HanoiGraph
  attr_reader :vertices
  attr_reader :edges

  def initialize(discs)
    if discs == 1
      @vertices = [
        [1],
        [2],
        [3]
      ]
      @edges = {
        "1" => [2,3],
        "2" => [1,3],
        "3" => [1,2]
      }
    else
      raise "Not Implemented"
    end
  end
  
  def shortest_path(from, to)
    infinity = -1
    path = {}
    visited = {from => true}
    queue = [from]

    while queue.length > 0 and current = queue.pop and current != to
      @edges[current].each do |a|
        i = a-1
        key = @vertices[i].join
        if !visited[key]
          visited[key] = true
          queue.unshift(key)
          path[key] = i
        end
      end
    end

    moves = []
    rewind = to
    #while rewind != nil
    # rewind = path[rewind]
    #end
    puts path
    moves.reverse()
  end
end

g = HanoiGraph.new 1
g.shortest_path "1", "3"
