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

if __FILE__ == $0
  n = Integer(ARGF.readline)
  #count factors of n!
end