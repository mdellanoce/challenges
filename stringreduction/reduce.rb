class Reducer
  def reduce(str)
    smallest = str.length
    potentials = reductions(str)
    
    for reduction in potentials
      r = reduce reduction
      
      if r < smallest
        smallest = r
      end

      if smallest <= 2
        break
      end
    end

    smallest
  end
  
  protected
  
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
end

if __FILE__ == $0
  cases = Integer(ARGF.readline)
  reducer = Reducer.new
  cases.times do
    t = ARGF.readline.strip
    puts reducer.reduce(t)
  end
end
