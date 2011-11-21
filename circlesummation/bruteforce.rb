class Array
  #Thank you, backports
  def rotate(n=1)
    dup.rotate!(n)
  end unless method_defined? :rotate

  def rotate!(n=1)
    return self if empty?
    n %= size
    concat(slice!(0, n))
  end unless method_defined? :rotate!

  def circle_sum(rounds)
    l = length
    raise "expected length at least 3, but was #{l}" if l < 3
    return self if rounds == 0

    result = []
    (0...l).each do |start_index|
      iv = rotate(start_index)
      sum = iv.brute_force(rounds)
      result.push sum.rotate(-start_index)
    end
    result
  end

  protected

  def brute_force(rounds)
    len = length
    sum = dup
    
    i = 0
    rounds.times do
      n1 = (i-1)%len
      n2 = (i+1)%len
      current = i%len
      sum[current] = sum[current] + sum[n1] + sum[n2]
      i+=1
    end
    sum
  end
end

if __FILE__ == $0
  cases = Integer(ARGF.readline)
  (0...cases).each do |i|
    puts if i > 0
  
    children, rounds = ARGF.readline.split.map {|x| Integer(x)}
    seed = ARGF.readline.split.map {|x| Integer(x)}
    s = seed.circle_sum(rounds)
    s.each_with_index do |row, r|
      print row.map {|a| a%1000000007}.join(" ")
      puts if r < children-1 or i < cases-1
    end
  end

  print " "
end
