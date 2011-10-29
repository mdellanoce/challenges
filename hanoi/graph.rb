class State
  def initialize(pegs, state)
    @pegs = pegs
    @state = state
  end
  
  def legal_moves
    moves = []
    @state.each_with_index do |source, disc|
      1.upto(@pegs) do |destination|
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
    next_state = @state.dup
    #TODO - state transition
    State.new @pegs, next_state
  end

  def to_s
    return @state.join(" ")
  end

  def ==(other)
    return to_s == other.to_s
  end
end

class HanoiGraph
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
