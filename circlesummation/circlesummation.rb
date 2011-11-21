require 'matrix'

class Matrix
  MOD = 1000000007
  
  alias :old_mult :*
  
  def *(m)
    x = old_mult m
    x.collect {|e| e%Matrix::MOD}
  end
end

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

  def circle_sum_fast(rounds)
    l = length
    raise "expected length at least 3, but was #{l}" if l < 3
    return self if rounds == 0
    m = Matrix.build(l, l) do |row, col|
      if row < l-1
        col == row+1 ? 1 : 0
      else
        (col > 1 and col < l-1) ? 0 : 1
      end
    end
    m = m**rounds

    result = []
    (0...l).each do |start_index|
      iv = Matrix.column_vector rotate(start_index)
      sum = (m*iv).column(0).to_a.rotate(-rounds%l)
      result.push sum.rotate(-start_index)
    end
    result
  end
end

if __FILE__ == $0
  cases = Integer(ARGF.readline)
  (0...cases).each do |i|
    puts if i > 0
  
    children, rounds = ARGF.readline.split.map {|x| Integer(x)}
    seed = ARGF.readline.split.map {|x| Integer(x)}
    s = seed.circle_sum_fast(rounds)
    s.each_with_index do |row, r|
      print row.map {|a| a%Matrix::MOD}.join(" ")
      puts if r < children-1 or i < cases-1
    end
  end
end
