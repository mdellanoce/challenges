k = Integer(ARGF.readline.split[1])
set1 = ARGF.readline.split.map {|x| Integer(x)}

set2 = set1.map {|x| x + k}

puts (set1 & set2).length