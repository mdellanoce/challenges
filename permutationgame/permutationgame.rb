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
