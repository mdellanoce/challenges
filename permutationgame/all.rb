n = Integer(ARGV[0])
d = (1..n).to_a

puts d.inject(:*)
d.permutation.each do |p|
  puts p.length
  puts p.join " "
end
