t = Integer(ARGV[0])
alphabet = ARGV[1]

max = ARGV[2] || 100000
max = max.to_i

puts t
t.times do
  s = ""
  max.times do
    s << alphabet[rand(alphabet.length-1)]
  end
  puts s
end
