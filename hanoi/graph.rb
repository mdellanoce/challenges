class Array
  def are_all_same?
    return false if empty?
    count(first) == size
  end
end

class State
  def initialize(pegs, state)
    @pegs = pegs
    @state = state
  end
  
  def legal_moves
    moves = []
    1.upto(@pegs) do |destination|
      @state.each_with_index do |source, disc|
      smaller_discs = @state[0...disc]
        under_smaller_disc = smaller_discs.count(source) > 0
        move_to_self = destination == source
        destination_has_smaller_disc = smaller_discs.count(destination) > 0

        moves.push [source,destination] if !move_to_self and
          !destination_has_smaller_disc and
          !under_smaller_disc
      end
    end
    moves
  end
  
  def move(move)
    #return next state
    @state.dup
  end
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
    @state.join(" ")
  end
  
  def concat(state)
    state.each do |s|
      @state.push(s)
    end
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
      pegs = 3
      h1 = HanoiGraph.new 1
      graphs = [
        HanoiGraph.new(discs-1),
        HanoiGraph.new(discs-1),
        HanoiGraph.new(discs-1)
      ]
      
      @vertices = []
      @edges = {}
      (0...pegs).each do |peg|
        graphs[peg].vertices.each do |vertex|
          vertex.concat h1.vertices[peg].state
          @vertices.push vertex
        end
        
        graphs[peg].edges.each do |vertex_key, vertices|
          @edges["#{vertex_key} #{h1.vertices[peg]}"] = vertices.map {|v| v + (pegs**(discs-1))*peg}
        end
      end
    end
    
    #TODO figure out how to link subgraphs programmatically...
    if discs == 2
      @edges["2 1"].push 8
      @edges["3 1"].push 6
      @edges["1 2"].push 7
      @edges["3 2"].push 3
      @edges["1 3"].push 4
      @edges["2 3"].push 2
    elsif discs == 3
      @edges["2 2 1"].push 23
      @edges["3 3 1"].push 18
      @edges["1 1 2"].push 19
      @edges["3 3 2"].push 9
      @edges["1 1 3"].push 10
      @edges["2 2 3"].push 5
    elsif discs != 1
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
