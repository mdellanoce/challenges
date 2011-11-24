class Position
  def initialize(state)
    @state = state
  end

  def to_s
    @state.join " "
  end

  def is_winning?
    if @is_winning == nil
      @is_winning = (0...@state.length-1).all? do |i|
        @state[i] < @state[i+1]
      end
    end
    @is_winning
  end

  def next_positions
    if !@positions
      @positions = []
        if !is_winning?
        (0...@state.length).each do |i|
          s = @state.dup
          s.delete_at i
          @positions.push Position.new(s)
        end
      end
    end
    @positions
  end
end

if $0 == __FILE__
  t = Integer(ARGF.readline)
  t.times do
    n = Integer(ARGF.readline)
    state = ARGF.readline.split.map {|a| Integer(a)}.to_a

    p = Position.new state
    puts p.to_s
  end
end
