class Task
  attr_reader :deadline
  attr_reader :time

  def initialize(deadline, time)
    @deadline = deadline
    @time = time
  end

  def <=>(other)
    a = deadline <=> other.deadline
    return a if a != 0
    time <=> other.time
  end

  def to_s
    "#{deadline} #{time}"
  end
end

class Array
  def insert_sorted(obj)
    a = 0
    0.upto(length) do |i|
      a = i
      break if (i==length) or (obj <=> self[i]) < 0
    end
    if a == length
      push obj
    else
      insert a,obj
    end
  end
end

if $0 == __FILE__
  tasks = []

  t = Integer(ARGF.readline)
  t.times do
    d,m = ARGF.readline.split.map {|i| Integer(i)}
    
    new_task = Task.new(d,m)
    tasks.insert_sorted new_task
    puts tasks.inspect

    time = 0
    overshoot = 0
    tasks.each do |task|
      time += task.time
      overshoot = [time - task.deadline, overshoot].max
    end

    puts overshoot
  end
end
