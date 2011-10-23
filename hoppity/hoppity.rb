class Integer
  def is_divisible_by?(number)
    self % number == 0
  end
end

class Hoppity
  def self.hoppity(number)
    raise "Expected a positive integer" if number <= 0

    1.upto(number) do |i|
      hop(i)
    end
  end

  def self.hop(number)
    if number.is_divisible_by? 3 and number.is_divisible_by? 5
      puts "Hop"
    elsif number.is_divisible_by? 3
      puts "Hoppity"
    elsif number.is_divisible_by? 5
      puts "Hophop"
    end
  end
end

Hoppity.hoppity Integer(ARGF.first)
