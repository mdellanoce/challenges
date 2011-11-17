#returns the number of times a prime (p) occurs in a factorial (n)
def multiplicity(n, p)
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

class Integer
  def factorial
    f = 1
    c = 1
    while c <= self do
      f *= c
      c += 1
    end
    f
  end
  
  def count_factors
    i = 0
    f = 1
    while f <= self do
      i += 1 if self % f == 0
      f += 1
    end
    i
  end
end

class Equations
  def self.brute_force(n)
    (n.factorial**2).count_factors
  end
end

if __FILE__ == $0
  n = Integer(ARGF.readline)
  puts Equations.brute_force(n) % 1000007
end