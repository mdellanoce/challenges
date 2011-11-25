class Position
  def initialize(state)
    @state = state
  end

  def to_s
    @state.join " "
  end

  def is_increasing?
    return true if @state.length == 1
    if @is_increasing == nil
      @is_increasing = (0...@state.length-1).all? do |i|
        @state[i] < @state[i+1]
      end
    end
    @is_increasing
  end

  def is_decreasing?
    return false if @state.length == 1
    if @is_decreasing == nil
      @is_decreasing = (0...@state.length-1).all? do |i|
        @state[i] > @state[i+1]
      end
    end
    @is_decreasing
  end

  def next_positions
    if !@positions
      @positions = []
      if !is_increasing?
        (0...@state.length).each do |i|
          s = @state.dup
          s.delete_at i
          @positions.push Position.new(s)
        end
      end
    end
    @positions
  end

  def remaining_moves
    @state.length - 1
  end

  def moves(count=1)
    #First, try to find a move that guarantees a win
    next_positions.each_with_index do |p, i|
      if p.is_increasing?
        #if there is a move that results in a winning position, we should take it
        puts @state[i]
        break
      elsif p.is_decreasing? and p.remaining_moves.odd? != count.odd?
        #if there is a move that forces a winning position for us, we should take it
        puts @state[i]
        count += p.remaining_moves
        break
      end
    end

    #TODO - Search next positions for a potentially advantageous position

    count
  end
end

if $0 == __FILE__
  t = Integer(ARGF.readline)
  t.times do
    n = Integer(ARGF.readline)
    state = ARGF.readline.split.map {|a| Integer(a)}.to_a

    p = Position.new state
    puts p.to_s
    m = p.moves
    if m.odd?
      puts "ALICE"
    else
      puts "BOB"
    end
  end
end
