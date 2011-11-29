t = Integer(ARGV[0])
puts t
t.times do
  n = Integer(ARGV[1])
  d = (1..n).to_a.shuffle
  puts n
  puts d.join " "
end
