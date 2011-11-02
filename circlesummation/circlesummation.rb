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
    i = start_index
    l = length
    raise "Expected length greater than 2, but was #{l}" if l < 3
    
    sum = dup
    rounds.times do
      n1 = (i-1)%l
      n2 = (i+1)%l
      current = i%l
      
      sum[current] = sum[current] + sum[n1] + sum[n2]
      
      i+=1
    end
    sum
  end
  
  def circle_sum_fast(start_index, rounds)
    #rotate + start index
    #compute closed form solution for each array component
    #rotate - start index
    raise "not implemented"
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