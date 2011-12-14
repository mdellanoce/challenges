class Task
  attr_reader :deadline
  attr_accessor :done
  attr_reader :time

  def initialize(deadline, time)
    @deadline = deadline
    @time = time
    @done = time
  end

  def <=>(other)
    a = deadline <=> other.deadline
    if a == 0
      a = time <=> other.time
    end
    a
  end

  def overshoot
    [0,done-deadline].max
  end

  def to_s
    "#{deadline} #{time} => #{done} #{overshoot}"
  end
end

class Array
  def insert_sorted(task)
    a = 0
    overshoot = task.overshoot
    each do |t|
      if (task <=> t) < 0
        t.done += task.time
      else
        task.done += t.time
        a+=1
      end
      overshoot = [overshoot, task.overshoot, t.overshoot].max
    end
    insert a,task
    overshoot
  end
end

if $0 == __FILE__
  tasks = []

  t = Integer(ARGF.readline)
  t.times do
    d,m = ARGF.readline.split.map {|i| Integer(i)}
    
    new_task = Task.new(d,m)
    puts tasks.insert_sorted(new_task)
  end
end
