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

  def stone_pile_moves
    if !defined? @@moves
      if File.exists? 'moves.txt'
        @@moves = eval(File.open('moves.txt', 'rb').read)
      else
        @@moves = [[],[],[]]
      end
    end

    if self >= @@moves.length
      g = grundy_moves
      n = []
      g.each do |move|
        move.each_with_index do |m,i|
          m.stone_pile_moves.each do |s|
            t = move.dup
            t[i] = s
            t.flatten!.sort!
            n.push t if t.uniq?
          end
        end
      end
      @@moves[self] = (g + n).uniq
    end

    @@moves[self]
  end
end

class Array
  def uniq?
    length == uniq.length
  end

  def mex
    m = 0
    sort.each do |i|
      break if m < i
      m+=1 if m == i
    end
    m
  end
end

class Grundy
  def self.values(n)
    n += 1
    @@lookup ||= [0,0,0]

    if n > @@lookup.length
      @@lookup.length.upto(n).each do |i|
        @@lookup[i] = i.stone_pile_moves.map do |move|
          move.map {|m| @@lookup[m]}.inject(:^)
        end.mex
      end
    end

    @@lookup.slice(0,n)
  end
end

if $0 == __FILE__
	i = Integer(ARGF.readline)
  puts Grundy.values(i).inspect
end
