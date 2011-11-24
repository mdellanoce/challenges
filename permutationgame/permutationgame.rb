class Position
  def initialize(state)
    @state = state
  end

  def to_s
    @state.join " "
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
