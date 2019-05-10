require "json"
require "crz"

class CodeGenerator
  alias TypeJSON = Hash(String, Array(Hash(String, (Int32 | String))))
  alias FunctionJSON = Hash(String, Array(Hash(String, (Bool | Int32 | String | Array(Hash(String, String)) | Hash(String, String)))))

  def types_file
    @types_file ||= File.read(File.expand_path("json/structs_and_enums.json", dir: __DIR__))
  end

  def functions_file
    @functions_file ||= File.read(File.expand_path("json/definitions.json", dir: __DIR__))
  end

  def well_known_types
    {
      "bool"                  => "Bool",
      "char"                  => "LibC::Char",
      "double"                => "LibC::Double",
      "float"                 => "LibC::Float",
      "int"                   => "LibC::Int",
      "long"                  => "LibC::Long",
      "short"                 => "LibC::Short",
      "size_t"                => "LibC::SizeT",
      "void"                  => "Void",
      "unsigned char"         => "LibC::UChar",
      "unsigned int"          => "LibC::UInt",
      "unsigned long"         => "LibC::ULong",
      "unsigned short"        => "LibC::UShort",
      "ImWchar"               => "LibC::UShort",
      "ImVec2"                => "Vector2",
      "ImVec2_Simple"         => "Vector2",
      "ImVec3"                => "Vector3",
      "ImVec4"                => "Vector4",
      "ImVec4_Simple"         => "Vector4",
      "ImColor_Simple"        => "ImColor",
      "ImTextureID"           => "Void*",
      "ImGuiID"               => "LibC::UInt",
      "ImDrawIdx"             => "LibC::UShort",
      "ImDrawListSharedData"  => "Void*",
      "ImDrawListSharedData*" => "Void*",
      "ImU32"                 => "LibC::UInt",
      "ImDrawCallback"        => "Void*",
      "ImGuiContext*"         => "Void*",
      "float[2]"              => "Vector2*",
      "float[3]"              => "Vector3*",
      "float[4]"              => "Vector4*",
      "int[2]"                => "LibC::Int*",
      "int[3]"                => "LibC::Int*",
      "int[4]"                => "LibC::Int*",
      "float&"                => "LibC::Float*",
      "ImVec2[2]"             => "Vector2*",
      "char* []"              => "LibC::Char**",
    }
  end

  def custom_defined_types
    {
      "ImVector" => true,
      "ImVec2"   => true,
      "ImVec4"   => true,
      "Pair"     => true,
    }
  end

  def types_from_json(root)
    TypeJSON.from_json(types_file, root)
  end

  def enums_json
    @enums_json ||= types_from_json("enums").as(TypeJSON)
  end

  def enums
    @enums ||= enums_json.map { |name, members|
      EnumDefinition.new(
        name,
        members.map { |m| EnumMember.new(m["name"].to_s, m["value"].to_s) }
      )
    }.as(Array(EnumDefinition))
  end

  def types_json
    @types_json ||= types_from_json("structs").as(TypeJSON)
  end

  def types
    @types ||= types_json.map { |name, fields|
      TypeDefinition.new(
        name,
        fields.each_with_object([] of TypeReference) { |field, refs|
          refs << TypeReference.new(
            field["name"].to_s,
            field["type"].to_s,
            field["template_type"]?.try(&.to_s),
            enums
          ) unless field["type"].to_s.index("static")
        }
      )
    }.as(Array(TypeDefinition))
  end

  def functions_json
    @functions_json ||= FunctionJSON.from_json(functions_file)
  end

  def functions
    @functions ||= functions_json.map { |name, overloads|
      non_udt_variants? = overloads.any? { |o| o["ov_cimguiname"]?.try(&.to_s.ends_with?("nonUDT")) }
      FunctionDefinition.new(
        name,
        overloads.each_with_object([] of OverloadDefinition) { |overload, defs|
          ov_cimguiname = overload["ov_cimguiname"]?.to_s
          cimguiname = overload["cimguiname"]?.to_s
          friendly_name = overload["funcname"]?.try(&.to_s)
          friendly_name = "Destroy" if cimguiname.ends_with?("_destroy")
          next unless friendly_name
          exported_name = ov_cimguiname
          exported_name = cimguiname if exported_name.empty?
          next if non_udt_variants? && !exported_name.ends_with?("nonUDT2")
          underscore_pos = exported_name.index('_')
          fix_function_name? = !underscore_pos.nil? && underscore_pos > 0
          fix_function_name? &= !exported_name.starts_with?("ig")
          self_type_name = exported_name[0...underscore_pos.not_nil!] if fix_function_name?
          parameters = overload["argsT"].as(Array(Hash(String, String))).map { |arg|
            TypeReference.new(
              arg["name"].to_s,
              arg["type"].to_s,
              nil,
              enums
            )
          }.as(Array(TypeReference))
          default_values = begin
            overload["defaults"].as(Hash(String, String))
          rescue e : TypeCastError
            {} of String => String
          end
          return_type = overload["ret"]?.try(&.to_s) || "void"
          struct_name = overload["stname"]?.to_s
          is_constructor = false
          is_destructor = false
          defs << OverloadDefinition.new(
            exported_name,
            friendly_name,
            parameters,
            default_values,
            return_type,
            struct_name,
            "",
            is_constructor,
            is_destructor
          )
        }.as(Array(OverloadDefinition))
      )
    }.as(Array(FunctionDefinition))
  end

  def output_path
    @output_path ||= File.expand_path("../crimgui/imgui.cr", dir: __DIR__)
  end

  def code_writer
    @code_writer ||= CodeWriter.new(output_path)
  end

  def generate
    code_writer.begin_block("lib ImGui")
    code_writer.write("# enums")
    generate_enums
    code_writer.write("# types")
    generate_types
    code_writer.end_block
    code_writer.finish
  end

  def generate_enums
    enums.each do |enum_def|
      code_writer.write("@[Flags]") if enum_def.name.index("Flags")
      code_writer.begin_block("enum #{enum_def.name}")
      enum_def.sanitized_names.each do |k, member|
        member.each do |name, value|
          code_writer.write("#{name} = #{value}")
        end
      end
      code_writer.end_block
      code_writer.write("")
    end
  end

  def generate_types
    types.each do |type_def|
      next if custom_defined_types[type_def.name]?
      code_writer.begin_block("struct #{type_def.name}")
      type_def.fields.each do |field|
        type_str = type_string(field.type, field.function_pointer?)
        if field.array_size > 0
        elsif type_str
          code_writer.write("#{field.name} : #{type_str}")
        end
      end
      code_writer.end_block
      code_writer.write("")
    end
  end

  def type_string(type_name, is_function_pointer)
    type_str = nil
    ptr_level = 0
    while type_name[-1 * ptr_level - 1] == '*'
      ptr_level += 1
    end
    type_str ||= well_known_types[type_name]?
    type_str ||= well_known_types[type_name[0...-ptr_level]]? if ptr_level > 0
    type_str = type_str.not_nil! + "*" * ptr_level if type_str && ptr_level > 0
    type_str ||= type_str.nil? && is_function_pointer ? "Void*" : type_name
    type_str
  end
end

# Custom Types

struct Vector2
  property x, y

  def initialize(@x : LibC::Float, @y : LibC::Float)
  end
end

struct Vector3
  property x, y, z

  def initialize(@x : LibC::Float, @y : LibC::Float, @z : LibC::Float)
  end
end

struct Vector4
  property x, y, z, w

  def initialize(@x : LibC::Float, @y : LibC::Float, @z : LibC::Float, @w : LibC::Float)
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

# Code gen

class CodeWriter
  property path : String,
    file : File?,
    indent : Int32

  def initialize(@path : String)
    @indent = 0
  end

  def file
    @file ||= File.new(path, "w")
  end

  def begin_block(line)
    write_indented(line)
    @indent += 2
  end

  def end_block
    @indent -= 2
    write_indented("end")
  end

  def write(line)
    write_indented(line)
  end

  def write_indented(line)
    str = String.build do |s|
      indent.times { s << ' ' }
      s << line
      s << "\n"
    end
    file << str
  end

  def finish
    file.close
  end
end

class EnumDefinition
  property raw_name : String,
    name : String?,
    members : Array(EnumMember),
    sanitized_names : Hash(String, Hash(String, String))?

  def initialize(@raw_name : String, @members : Array(EnumMember))
  end

  def name
    @name ||= raw_name.rchop("_")
  end

  def sanitized_names
    @sanitized_names ||= members.reduce({} of String => Hash(String, String)) do |names, element|
      names.merge({element.name => {element.name.lchop(raw_name).rchop("_").lchop("_") => element.value.gsub(raw_name, "").rchop("_")}})
    end
  end
end

class EnumMember
  property name : String,
    value : String

  def initialize(@name : String, @value : String)
  end
end

class TypeDefinition
  property name, fields

  def initialize(@name : String, @fields : Array(TypeReference))
  end
end

class TypeReference
  include CRZ

  property raw_name : String,
    raw_type : String,
    name : String?,
    type : String?,
    template_type : String?,
    size_part : String?,
    array_size : Int32?,
    enums : Array(EnumDefinition)

  def initialize(
    @raw_name : String,
    @raw_type : String,
    @template_type : String?,
    @enums : Array(EnumDefinition)
  )
  end

  def name
    @name ||= array_size == -1 ? raw_name.underscore : raw_name.split('[').first.underscore
  end

  def type
    @type ||= chain raw_type, remove_const, remove_underscore
  end

  def remove_const(str)
    str.sub("const", "").strip
  end

  def remove_underscore(str)
    str.index("ImVector_") == 0 ? (str[-1] == '*' ? "ImVector*" : "ImVector") : str
  end

  def size_part
    @size_part ||= raw_name.match(/\[(.*)\]/).try(&.[1])
  end

  def array_size
    @array_size ||= size_part.nil? ? -1 : parse_size_string(size_part.not_nil!)
  end

  def parse_size_string(str)
    return str.split('+').map(&.to_i).sum if str.index('+')
    return str.to_i if str.to_i?
    members = [] of EnumMember
    enums.each_with_object(members) { |ed, m| m.concat(ed.members) if str.index(ed.name) == 0 }
    members.find { |m| m.name == str && m.value.to_i? }.try(&.value.to_i) || -1
  end

  def function_pointer?
    !type.index('(').nil?
  end
end

class FunctionDefinition
  property name, overloads

  def initialize(@name : String, @overloads : Array(OverloadDefinition))
  end
end

class OverloadDefinition
  property raw_name : String,
    name : String,
    params : Array(TypeReference),
    default_values : Hash(String, String),
    return_type : String,
    struct_name : String,
    comment : String,
    is_constructor : Bool,
    is_destructor : Bool

  def initialize(
    @raw_name : String,
    @name : String,
    @params : Array(TypeReference),
    @default_values : Hash(String, String),
    return_type : String,
    @struct_name : String,
    @comment : String,
    @is_constructor : Bool,
    @is_destructor : Bool
  )
    @return_type = return_type.sub("const", "").sub("inline", "").strip
  end

  def member_function?
    !struct_name.strip.empty?
  end

  def constructor?
    is_constructor
  end

  def destructor?
    is_destructor
  end
end

class MarshalledParameter
  property type : String,
    is_pinned : Bool,
    var_name : String,
    has_default_value : Bool,
    pin_target : String?

  def initialize(@type : String, @is_pinned : Bool, @var_name : String, @has_default_value : Bool)
  end

  def pinned?
    is_pinned
  end

  def default_value?
    has_default_value
  end
end

gen = CodeGenerator.new
# p gen.types_json

puts "\n\n\n"

# puts gen.enums

puts "\n\n\n"

# puts gen.types

puts "\n\n\n"

gen.generate

# puts gen.functions

# puts nil.to_i

# edef = EnumDefinition.new("Test_", [] of EnumMember)
# puts edef.name

# edef = EnumDefinition.new("Test123", [] of EnumMember)
# puts edef.name

# TypeDefinition.new("test", [] of TypeReference)

# puts TypeReference.new("CustomRectIds[1+4]", "", nil, [] of EnumDefinition).size_part

# arr = [] of Int32

# arr.concat([1, 2, 3])
# arr.concat([4, 5, 6])

# puts arr.find { |a| a == 10 }.try(&.to_s.+("23"))

# p gen.well_known_types

# v1 = Vector2.new(0, 0)
# p1 = Pair.new(0, 3.1245)

# puts v1.x
# puts p1

# ptr = Pointer.malloc(5) { |i| i == 4 ? 0_u8 : ('a'.ord + i).to_u8 }
# ptr = Pointer.malloc(5) { |i| i == 4 ? 0_0f32 : i.to_f32 * 3.14 }

# used_chars = ImVector(LibC::Float).new(5, 5, Box.box(ptr))

# puts used_chars[0]
# puts used_chars[1]
# puts used_chars[2]
# puts used_chars[3]
# puts used_chars[4]
