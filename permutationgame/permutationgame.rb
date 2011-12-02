class Array
  def longest_increasing
    longest :<
  end

  def longest_decreasing
    longest :>
  end

  protected

  def longest(cmp)
    max = 1
    dp = [1]

    1.upto(length-1).each do |i|
      dp[i] = 1

      (i-1).downto(0).each do |j|
        if dp[j] + 1 > dp[i] and self[j].send(cmp, self[i])
          dp[i] = dp[j] + 1
        end
      end

      if dp[i] > max
        max = dp[i]
      end
    end

    max
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
    "I:#{@state.longest_increasing},D:#{@state.longest_decreasing}"
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

    values = ([-99999] + next_positions.map do |p|
      if p.is_winning?
        remaining_moves
      elsif p.is_losing?
        -remaining_moves
      else
        -p.minimax
      end
    end.to_a)

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
    puts m > 0 ? "#{p.to_s}: #{p.debug} => ALICE" : "#{p.to_s}: #{p.debug} => BOB"
  end
end
