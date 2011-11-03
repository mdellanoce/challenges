class Coefficients
  def self.generate(rounds, len)
    raise "Expected length greater than 2, but was #{len}" if len < 3
    
    coefficients = []
    (0...len).each do |r|
      row = [0] * len
      row[r] = 1
      coefficients.push row
    end
    
    i = 0
    rounds.times do
      n1 = (i-1)%len
      n2 = (i+1)%len
      current = i%len
      
      coefficients[current] = coefficients[current].add_each(coefficients[n1]).add_each(coefficients[n2])
      
      i+=1
    end
    
    coefficients
  end
end

class Array
  def add_each(other)
    zip(other).map {|i,j| i+j}
  end

  def multiply_each(other)
    zip(other).map {|i,j| i*j}
  end

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
    start = dup
    start.rotate! start_index
    sum = []
    
    coefficients = Coefficients.generate(rounds, length)
    
    (0...length).each do |i|
      sum[i] = start.multiply_each(coefficients[i]).inject(:+)
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
