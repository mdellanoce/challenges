def reductions(str)
  reductions = []
  0.upto(str.length-1) do |i|
    r = i..i+1
    s = str[r]
    if s == "ac" or s == "ca"
      t = str.dup
      t[r] = "b"
      reductions.push t
    elsif s == "bc" or s == "cb"
      t = str.dup
      t[r] = "a"
      reductions.push t
    elsif s == "ab" or s == "ba"
      t = str.dup
      t[r] = "c"
      reductions.push t
    end
  end
  reductions
end

def reduce(str)
  potentials = reductions(str)
  
  if potentials.any?
    potentials.map do |reduction|
      reduce reduction
    end.min
  else
    str.length
  end
end

if __FILE__ == $0
  cases = Integer(ARGF.readline)
  cases.times do
    reduce ARGF.readline
  end
end