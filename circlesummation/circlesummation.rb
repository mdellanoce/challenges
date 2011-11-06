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

  def circle_sum(start_index, rounds)
    len = length
    sum = dup
    sum.rotate! start_index
    
    i = 0
    rounds.times do
      n1 = (i-1)%len
      n2 = (i+1)%len
      current = i%len
      
      sum[current] = sum[current] + sum[n1] + sum[n2]
      
      i+=1
    end
    
    sum.rotate -start_index
  end
end

if __FILE__ == $0
  cases = Integer(ARGF.readline)
  (0...cases).each do |i|
    puts if i > 0
  
    children, rounds = ARGF.readline.split.map {|x| Integer(x)}
    seed = ARGF.readline.split.map {|x| Integer(x)}
    (0...children).each do |child|
      print seed.circle_sum(child, rounds).map {|a| a%1000000007}.join(" ")
      puts if child < children-1 or i < cases-1
    end
  end
end
