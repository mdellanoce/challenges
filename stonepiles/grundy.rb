require 'pp'

class Integer
  def grundy_moves
    n = self
  	return [] if n < 3
  
  	positions = []
  	1.upto(n/2) do |i|
  		if i != n-i
  			positions.push([i, n-i])
  		end
  	end
  
  	positions
  end
end

class Array
  def mex
    m = 0
    sort.each do |i|
      break if m < i
      m+=1
    end
    m
  end
end

if $0 == __FILE__
	pp Integer(ARGF.readline).grundy_moves
end
