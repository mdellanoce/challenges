class Array
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
end

if __FILE__ == $0
  cases = Integer(ARGF.readline)
  (0...cases).each do |i|
    puts if i > 0
  
    children, rounds = ARGF.readline.split.map {|x| Integer(x)}
    seed = ARGF.readline.split.map {|x| Integer(x)}
    (0...children).each do |child|
      method = (child == children-1 and i == cases-1) ? :print : :puts
      self.send(method, seed.circle_sum(child, rounds).join(" "))
    end
  end
end