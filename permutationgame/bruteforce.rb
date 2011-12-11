class Array
  def format
    map do |s|
      "%4d" % s
    end.join
  end
end

class Position
  def initialize(state)
    @state = state
  end

  def to_s
    @str ||= @state.format
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

  def is_winning?
    is_increasing? or (is_decreasing? and remaining_moves.even?)
  end

  def is_losing?
    is_decreasing? and remaining_moves.odd?
  end

  def next_positions
    if !@positions
      @positions = []
      if !is_increasing?
        (0...@state.length).each do |i|
          s = @state.dup
          r = s.delete_at i
          s.map! {|x| x>r ? x-1 : x}
          @positions.push Position.new(s)
        end
      end
    end
    @positions
  end

  def remaining_moves
    @state.length - 1
  end

  def minimax(debug=true)
    @@cache ||= {}
    return @@cache[to_s] if @@cache.has_key? to_s

    values = []
    next_positions.each do |p|
      if p.is_winning?
        values.push remaining_moves
        break
      end
    end

    if values.empty?
      next_positions.each do |p|
        if p.is_losing?
          values.push -remaining_moves
        else
          values.push -p.minimax(false)
        end
      end
    end

    puts values.format if debug
    score = values.max
    @@cache[to_s] = score
    score
  end
end

if $0 == __FILE__
  t = Integer(ARGF.readline)
  t.times do
    n = Integer(ARGF.readline)
    state = ARGF.readline.split.map {|a| Integer(a)}.to_a

    p = Position.new state
    debug = true
    m = p.minimax(debug)
    if debug
      puts m > 0 ? "#{p.to_s} => ALICE" : "#{p.to_s} => BOB"
    else
      puts m > 0 ? "ALICE" : "BOB"
    end
  end
end
