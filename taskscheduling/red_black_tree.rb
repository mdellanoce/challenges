class RedBlackTree
  include Enumerable
  
  attr_accessor :height_black
  
  def initialize
    @root = nil
  end
  
  def push(key, value=key)
    @root = insert(@root, key, value)
    @root.color = :black
    value
  end
  
  def size
    @root and @root.size or 0
  end
  
  def height
    @root and @root.height or 0
  end
  
  def empty?
    @root.nil?
  end
  
  def each
    return nil unless @root
    stack = []
    cursor = @root
    loop do
      if cursor
        stack.push(cursor)
        cursor = cursor.left
      else
        unless stack.empty?
          cursor = stack.pop
          yield(cursor.key, cursor.value)
          cursor = cursor.right
        else
          break
        end
      end
    end
  end
  
  class Node
    attr_accessor :color, :key, :value, :left, :right, :size, :height
    def initialize(key, value)
      @key = key
      @value = value
      @color = :red
      @left = nil
      @right = nil
      @size = 1
      @height = 1
    end
    
    def red?
      @color == :red
    end
    
    def colorflip
      @color       = @color == :red       ? :black : :red
      @left.color  = @left.color == :red  ? :black : :red
      @right.color = @right.color == :red ? :black : :red
    end
    
    def update_size
      @size = (@left ? @left.size : 0) + (@right ? @right.size : 0) + 1
      left_height = (@left ? @left.height : 0)
      right_height = (@right ? @right.height : 0)
      if left_height > right_height
        @height = left_height + 1
      else
        @height = right_height + 1
      end
      self
    end
    
    def rotate_left
      r = @right
      r_key, r_value, r_color = r.key, r.value, r.color
      b = r.left
      r.left = @left
      @left = r
      @right = r.right
      r.right = b
      r.color, r.key, r.value = :red, @key, @value
      @key, @value = r_key, r_value
      r.update_size
      update_size
    end
    
    def rotate_right
      l = @left
      l_key, l_value, l_color = l.key, l.value, l.color
      b = l.right
      l.right = @right
      @right = l
      @left = l.left
      l.left = b
      l.color, l.key, l.value = :red, @key, @value
      @key, @value = l_key, l_value
      l.update_size
      update_size
    end
    
    def move_red_left
      colorflip
      if (@right.left && @right.left.red?)
        @right.rotate_right
        rotate_left
        colorflip
      end
      self
    end

    def move_red_right
      colorflip
      if (@left.left && @left.left.red?)
        rotate_right
        colorflip
      end
      self
    end
    
    def fixup
      rotate_left if @right && @right.red?
      rotate_right if (@left && @left.red?) && (@left.left && @left.left.red?)
      colorflip if (@left && @left.red?) && (@right && @right.red?)

      update_size
    end
  end

  protected
  
  def insert(node, key, value)
    return Node.new(key, value) unless node

    case key <=> node.key
    when -1   then node.left = insert(node.left, key, value)
    when  1,0 then node.right = insert(node.right, key, value)
    end
    
    node.rotate_left if (node.right && node.right.red?)
    node.rotate_right if (node.left && node.left.red? && node.left.left && node.left.left.red?)
    node.colorflip if (node.left && node.left.red? && node.right && node.right.red?)
    node.update_size
  end
end
