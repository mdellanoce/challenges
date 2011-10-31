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

def reduce(str, lookup={})
  smallest = str.length
  potentials = reductions(str)
puts lookup.inspect
  return lookup[str] if lookup.has_key?(str)
  
  for reduction in potentials
    r = reduce(reduction, lookup)
    if r < smallest
      smallest = r
    end

    if smallest == 1
      break
    end
  end

  lookup[str] = smallest

  smallest
end

if __FILE__ == $0
  cases = Integer(ARGF.readline)
  cases.times do
    reduce ARGF.readline
  end
end
