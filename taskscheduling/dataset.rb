t = Integer(ARGV[0])
puts t

t.times do
  d = rand(t)
  m = rand(t)

  puts "#{d} #{m}"
end
