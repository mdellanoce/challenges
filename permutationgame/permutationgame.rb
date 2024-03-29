class Array
  def longest
    maxi = 1
    maxd = 1
    li = [1]
    ld = [1]

    1.upto(length-1).each do |i|
      li[i] = 1
      ld[i] = 1

      (i-1).downto(0).each do |j|
        if li[j] + 1 > li[i] and self[j] < self[i]
          li[i] = li[j] + 1
        end

        if ld[j] + 1 > ld[i] and self[j] > self[i]
          ld[i] = ld[j] + 1
        end
      end

      if li[i] > maxi
        maxi = li[i]
      end

      if ld[i] > maxd
        maxd = ld[i]
      end
    end

    [maxi, maxd]
  end
end

class Position
  def initialize(state)
    @state = state
  end

  def to_s
    @str ||= @state.join " "
  end

  def debug
    @longest ||= @state.longest
    "I:#{@longest[0]},D:#{@longest[1]}"
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

  def minimax
    @@cache ||= {}
    return @@cache[to_s] if @@cache.has_key? to_s

    values = [-99999]
    next_positions.each do |p|
      if p.is_winning?
        values.push remaining_moves
        break
      end
    end

    if values.length == 1
      values += (next_positions.map do |p|
        if p.is_losing?
          -remaining_moves
        else
          -p.minimax
        end
      end.to_a)
    end

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
    m = p.minimax
    #puts m > 0 ? "#{p.to_s}: #{p.debug} => ALICE" : "#{p.to_s}: #{p.debug} => BOB"
    puts m > 0 ? "ALICE" : "BOB"
  end
end
