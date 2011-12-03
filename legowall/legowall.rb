
if $0 == __FILE__
  t = Integer(ARGF.readline)
  t.times do
    height,width = ARGF.readline.split.map {|i| Integer(i)}
  end
end
