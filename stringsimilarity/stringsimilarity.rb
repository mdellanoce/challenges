class String
  def longest_common_prefix(other)
    min = [length, other.length, max].compact.min
    min.times do |i|
      return slice(0, i) if self[i] != other[i]
    end
    return slice(0, min)
  end

  def sum_of_suffix_prefixes
    l = length

    suffixes = Array.new(l)
    l.times do |i|
      suffixes[i] = slice(i, l)
    end
    
    suffixes.sort!
  end
end

if $0 == __FILE__
  t = Integer(ARGF.readline)
  t.times do
    s = ARGF.readline
    puts s.sum_of_suffix_prefixes
  end
end
