class Task
  attr_reader :deadline
  attr_reader :time

  def initialize(deadline, time)
    @deadline = deadline
    @time = time
  end
end

if $0 == __FILE__
  tasks = []

  t = Integer(ARGF.readline)
  t.times do
    d,m = ARGF.readline.split.map {|i| Integer(i)}
    tasks.push Task.new(d,m)
  end

  (0...t).each do |i|
    i_tasks = tasks[0..i].sort! {|t1,t2| t1.deadline <=> t2.deadline}

    time = 0
    overshoot = i_tasks.map do |j|
      time += j.time
      [time - j.deadline, 0].max
    end.max

    puts overshoot
  end
end
