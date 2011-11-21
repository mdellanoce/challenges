def compare_files(file1, file2)
  f1 = File.open(file1, "rb")
  f2 = File.open(file2, "rb")
  c1 = f1.read
  c2 = f2.read
  f1.close
  f2.close
  raise "files are not the same" if c1 != c2
end

max = 10**9
testfile = "test/correctness.txt"
bruteforce = "test/bruteforce.txt"
fast = "test/fast.txt"

(3..50).each do |n|
  (1..100).each do |m|
    puts "#{n} #{m}"

    File.open(testfile, "w") do |f|
      f.puts 1
      f.puts "#{n} #{m}"

      d = []
      n.times do
        d.push rand(max)
      end
      f.puts d.join(" ")
    end

    `cat #{testfile} | ruby bruteforce.rb > #{bruteforce}`
    `cat #{testfile} | ./circlesummation > #{fast}`

    compare_files(bruteforce, fast)

    File.delete(testfile)
    File.delete(bruteforce)
    File.delete(fast)
  end
end
