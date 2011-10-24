class Move
  attr_reader :start
  attr_reader :destination
  
  def initialize(start, destination)
    @start = start
    @destination = destination
  end
end

def hanoi(n, pegs)
  puts "#{n} #{pegs.inspect}"
  if n > 0
    if n == 1
      [Move.new pegs[0], pegs[1]]
    else
      p1,p2,p3 = pegs
      rest = pegs.slice(3) || []
      rest = rest.is_a?(Array) ? rest : [rest]

      k = rest.any? ? n/2 : n-1

      result = []
      result.concat hanoi(k, [p1,p3,p2] + rest)
      result.concat hanoi(n-k, [p1,p2] + rest)
      result.concat hanoi(k, [p3,p2,p1] + rest)
      
      result
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

moves = hanoi(num_discs, (1..num_pegs).to_a)

puts moves.length
moves.each do |move|
  puts "#{move.start} #{move.destination}"
end