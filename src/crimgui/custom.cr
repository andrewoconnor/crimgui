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

@[Extern]
struct ImVec4
  property x, y, z, w

  def initialize(x : Number, y : Number, z : Number, w : Number)
    @x = LibC::Float.new(x)
    @y = LibC::Float.new(y)
    @z = LibC::Float.new(z)
    @w = LibC::Float.new(w)
  end
end

@[Extern]
struct ImVector
  property size, capacity, data

  def initialize(@size : LibC::Int, @capacity : LibC::Int, @data : Void*)
  end
end

# struct Pair
#   property key, value

#   def initialize(@key : LibC::UInt, @value : (LibC::Int | LibC::Float | Void*))
#   end
# end
