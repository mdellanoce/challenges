class Move
  attr_reader :start
  attr_reader :destination
  
  def initialize(start, destination)
    @start = start
    @destination = destination
  end
end

class Disc < Integer
end

class Peg
  def initialize
    @discs = []
  end
  
  def push(disc)
    @discs.push(disc)
  end
  
  def pop
    @discs.pop
  end
  
  def [](i)
    @discs[i-1]
  end
end

class Pegs
  def initialize(pegs, state)
    @discs = state.length
    @pegs = []
    1.upto(pegs) do |peg|
      @pegs.push Peg.new
    end
    state.reverse.each_with_index do |peg, i|
      @pegs[peg - 1].push(@discs - i)
    end
  end
  
  def to_s
    result = ""
    @discs.downto(1) do |row|
      result += @pegs.map {|p| p[row] || "|"}.join(" ") + "\n"
    end
    result
  end
end

def hanoi(n, pegs)
  if n > 0
    if n == 1
      [Move.new pegs[0], pegs[1]]
    else
      p1,p2,p3 = pegs
      rest = pegs.slice(3) || []
      rest = rest.is_a?(Array) ? rest : [rest]

      k = rest.any? ? n/2 : n-1

      hanoi(k, [p1,p3,p2] + rest) +
      hanoi(n-k, [p1,p2] + rest) +
      hanoi(k, [p3,p2,p1] + rest)
    end
  end
end

num_discs = 0
num_pegs = 0
start_state = []
end_state = []

ARGF.each_with_index do |line, i|
  if i == 0
    num_discs, num_pegs = line.split.map {|x| Integer(x)}
  elsif i == 1
    start_state = line.split.map {|x| Integer(x)}
  elsif i == 2
    end_state = line.split.map {|x| Integer(x)}
  end
end

puts Pegs.new(num_pegs, start_state)

moves = hanoi(num_discs, (1..num_pegs).to_a)

puts moves.length
moves.each do |move|
  puts "#{move.start} #{move.destination}"
end