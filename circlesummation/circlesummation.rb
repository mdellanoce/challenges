class Array
  @@ratios = {
    3=>1.83928675521416,
    4=>1.61803398874989,
    5=>1.4970940487628,
    6=>1.41963276282294,
    7=>1.36525470661986,
    8=>1.32471795724475,
    9=>1.29318803564318,
    10=>1.26787477465004,
    11=>1.24704786238279,
    12=>1.22957360711001,
    13=>1.21467621204762,
    14=>1.20180572851637,
    15=>1.19056074964861,
    16=>1.1806409911774,
    17=>1.17181704715231,
    18=>1.16391044941624,
    19=>1.15678013975808,
    20=>1.1503130616326,
    21=>1.14441747258322,
    22=>1.1390180978367,
    23=>1.13405255711557,
    24=>1.12946868910431,
    25=>1.12522251988918,
    26=>1.12127670070556,
    27=>1.11759929262541,
    28=>1.11416281109192,
    29=>1.11094346741323,
    30=>1.10792056119871,
    31=>1.10507598965347,
    32=>1.10239384819822,
    33=>1.09986010308652,
    34=>1.09746232124563,
    35=>1.09518944594543,
    36=>1.09303160943068,
    37=>1.09097997556619,
    38=>1.08902660700424,
    39=>1.08716435250649,
    40=>1.08538675092307,
    41=>1.08368794901059,
    42=>1.08206263080516,
    43=>1.0805059566889,
    44=>1.07901351062446,
    45=>1.07758125430186,
    46=>1.07620548715831,
    47=>1.07488281140723,
    48=>1.07361010135574,
    49=>1.07238447640594,
    50=>1.07120327723172
  }

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
  
  def circle_sum_fast(start_index, rounds)
    n = length*100
    if rounds > n
      sum = circle_sum(start_index, n)
      raise "not implemented..." if rounds != 505 #TODO - fix
      for i in 0...sum.length
        sum[i] = (sum[i]*(@@ratios[length]**(rounds-n))).round
      end
      sum
    else
      circle_sum(start_index, rounds)
    end
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