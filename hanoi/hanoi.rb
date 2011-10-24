num_discs = 0
num_pegs = 0
start_state = []
end_state = []

def hanoi(n, pegs)
  if n > 0
    if n == 1
      [pegs[0], pegs[1]]
    else
      p1,p2,p3 = pegs
      rest = pegs.slice 3
      rest = rest.is_a?(Array) ? rest : [rest]

      #I think k is a given? Has something to do with end state
      k = rest.any? ? n - 1 : n/2

      [
        hanoi(k, [p1,p3,p2].concat(rest)),
        hanoi(n-k, [p1,p2].concat(rest)),
        hanoi(k, [p3,p2,p1].concat(rest))
      ]
    end
  end
end

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
  puts move.join(" ")
end