t = Integer(ARGV[0])
puts t

t.times do
  d = rand(100000)
  m = rand(1000)

  puts "#{d} #{m}"
end
