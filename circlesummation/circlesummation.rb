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