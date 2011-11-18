module Prime
  def atkin(limit)
    raise "Give me a block" if !block_given?
    
    is_prime = []
    sqrt = Math.sqrt(limit).floor
    x = 1
    
    while x <= sqrt do
      y = 1
      while y <= sqrt do
        x_squared = x*x
        y_squared = y*y
        x_squared_3 = 3*x_squared
      
        n = 4*x_squared+y_squared
        if n <= limit and (n % 12 == 1 or n % 12 == 5)
          is_prime[n] ^= true
        end
        
        n = x_squared_3+y_squared
        if n <= limit and n % 12 == 7
          is_prime[n] ^= true
        end
        
        n = x_squared_3-y_squared
        if x > y and n <= limit and n % 12 == 11
          is_prime[n] ^= true
        end
        
        y+=1
      end
      x+=1
    end
    
    n = 5
    while n <= sqrt do
      if is_prime[n]
        s = n*n
        k = s
        while k <= limit do
          is_prime[k] = false
          k+=s
        end
      end
      n+=1
    end
    
    yield(2)
    yield(3)
    
    n = 5
    while n <= limit do
      if is_prime[n]
        yield(n)
      end
      n+=2
    end
  end
end

class Equations
  @mod = 1000007
  
  class << self
    include Prime
  end
  
  def self.count_solutions(n)
    f = 1
    atkin(n) do |p|
      f *= (2*multiplicity(n, p)+1)
      f = f % @mod
    end
    f % @mod
  end
  
  def self.multiplicity(n, p)
    q = n
    m = 0
    return 0 if p > n
    return 1 if p > n / 2
    while q >= p do
      q /= p
      m += q
    end
    m
  end
end

if __FILE__ == $0
  n = Integer(ARGF.readline)
  puts Equations.count_solutions(n)
end