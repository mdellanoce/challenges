class HanoiState
  attr_reader :state

  def initialize(pegs, state)
    @pegs = pegs
    @state = state
    @str = state.join(" ")
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
  
  def make_move(move)
    next_state = @state.dup
    i = next_state.find_index move[0]
    next_state[i] = move[1]
    HanoiState.new @pegs, next_state
  end

  def move(to)
    @state.zip(to.state).select do |pair|
      pair.any? {|p| pair[0] != p}
    end.first
  end

  def to_s
    return @str
  end

  def ==(other)
    return to_s == other.to_s
  end

  def shortest_path(to)
    path = {}
    visited = {to_s => true}
    queue = [self]

    while queue.length > 0 and current = queue.pop and current != to
      moves = current.legal_moves
      moves.each do |m|
        to_visit = current.make_move m
        key = to_visit.to_s
        if !visited[key]
          visited[key] = true
          queue.unshift(to_visit)
          path[to_visit.to_s] = current
        end
      end
    end

    moves = []
    rewind = to
    while path[rewind.to_s] != nil
      s1 = path[rewind.to_s]
      s2 = rewind
      moves.push(s1.move(s2))
      rewind = s1
    end
    raise "Path from #{from} to #{to} not found" if moves.empty?
    moves.reverse()
  end
end

if __FILE__ == $0
  pegs = Integer(ARGF.readline.split[1])
  start_state = ARGF.readline.split.map {|x| Integer(x)}
  end_state = ARGF.readline.split.map {|x| Integer(x)}

  from = HanoiState.new pegs, start_state
  to = HanoiState.new pegs, end_state
  moves = from.shortest_path to

  puts moves.length
  moves.each do |move|
    puts move.join(" ")
  end
end
