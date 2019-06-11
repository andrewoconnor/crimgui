# Custom Types

@[Extern]
struct ImVec2
  property x, y

  def initialize(x : Number, y : Number)
    @x = LibC::Float.new(x)
    @y = LibC::Float.new(y)
  end

  def initialize(vec : SF::Vector2)
    @x = LibC::Float.new(vec.x)
    @y = LibC::Float.new(vec.y)
  end
end

struct Vector2(T)
  property x, y

  def initialize
    @x = @y = T.zero
  end

  def initialize(@x : T, @y : T)
  end

  def size : Int32
    2
  end

  def [](i : Int) : T
    case i
    when 0; @x
    when 1; @y
    else    raise IndexError.new
    end
  end

  def to_unsafe
    pointerof(@x).as(Void*)
  end
end

struct Vector3(T)
  property x, y, z

  def initialize
    @x = @y = @z = T.zero
  end

  def initialize(@x : T, @y : T, @z : T)
  end

  def size : Int32
    3
  end

  def [](i : Int) : T
    case i
    when 0; @x
    when 1; @y
    when 2; @z
    else    raise IndexError.new
    end
  end

  def to_unsafe
    pointerof(@x).as(Void*)
  end
end

struct Vector4
  property x, y, z, w

  def initialize
    @x = @y = @z = @w = T.zero
  end

  def initialize(@x : T, @y : T, @z : T, @w : T)
  end

  def size : Int32
    4
  end

  def [](i : Int) : T
    case i
    when 0; @x
    when 1; @y
    when 2; @z
    when 3; @w
    else    raise IndexError.new
    end
  end

  def to_unsafe
    pointerof(@x).as(Void*)
  end
end

struct Pair
  property key, value

  def initialize(@key : LibC::UInt, @value : (LibC::Int | LibC::Float | Void*))
  end
end

struct ImVec
  property size, capacity, data

  def initialize(@size : LibC::Int, @capacity : LibC::Int, @data : Void*)
  end
end

struct ImVector(T)
  property size, capacity, data, slice

  def initialize(vector : ImVector)
    @size = vector.size
    @capacity = vector.capacity
    @data = vector.data
    @slice = Slice(T).new(Box(Pointer(T)).unbox(data), capacity)
  end

  def initialize(@size : LibC::Int, @capacity : LibC::Int, @data : Void*)
    @slice = Slice(T).new(Box(Pointer(T)).unbox(data), capacity)
  end

  def [](index : Int)
    slice[index]
  end
end
