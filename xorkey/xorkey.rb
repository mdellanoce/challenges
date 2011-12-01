t = Integer(ARGF.readline)
t.times do
  n,queries = ARGF.readline.split.map {|i| Integer(i)}
  key = ARGF.readline.split.map {|i| Integer(i)}

  queries.times do
    a,p,q = ARGF.readline.split.map {|i| Integer(i)}
    puts key[p-1..q-1].map {|x| a ^ x}.max
  end
end
