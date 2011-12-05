require 'algorithms'

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

class PriorityQueue
  def initialize
    @heap = []
  end

  def push(val)
    @heap.push val
    i = @heap.length-1
    while i>0 do
      parent = (i-1)/2
      if (@heap[i] <=> @heap[parent]) < 0
        @heap[i],@heap[parent] = @heap[parent],@heap[i]
      end
      i=parent
    end
  end

  def pop
    val = min
    #TODO
    val
  end

  def min
    @heap[0]
  end

  def length
    @heap.length
  end
end

if $0 == __FILE__
  tasks = Containers::RubyRBTreeMap.new

  t = Integer(ARGF.readline)
  t.times do
    d,m = ARGF.readline.split.map {|i| Integer(i)}
    
    new_task = Task.new(d,m)
    tasks.push new_task, new_task

    time = 0
    overshoot = 0
    tasks.each do |task|
      time += task.time
      overshoot = [time - task.deadline, overshoot].max
    end

    puts overshoot
  end
end
