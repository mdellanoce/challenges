require './red_black_tree'

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
end

if $0 == __FILE__
  tasks = RedBlackTree.new

  t = Integer(ARGF.readline)
  t.times do
    d,m = ARGF.readline.split.map {|i| Integer(i)}
    
    new_task = Task.new(d,m)
    tasks.push new_task

    time = 0
    overshoot = 0
    tasks.each do |task|
      time += task.time
      overshoot = [time - task.deadline, overshoot].max
    end

    puts overshoot
  end
end
