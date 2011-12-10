class String
  def longest_common_prefix(other)
    lcp = 0
    chars.each_with_index do |c,i|
      if c != other[i]
        break
      end
      lcp+=1
    end
    lcp
  end

  def sum_of_suffix_prefixes
    l = length
    s = l
    1.upto(l) do |i|
      s += longest_common_prefix(slice(i, l))
    end
    s
  end
end

if $0 == __FILE__
  t = Integer(ARGF.readline)
  t.times do
    s = ARGF.readline.chomp
    puts s.sum_of_suffix_prefixes
  end
end
