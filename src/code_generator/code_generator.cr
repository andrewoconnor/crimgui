require "json"
require "crz"

class CodeGenerator
  alias FunctionJSON = Hash(String, Array(Hash(String, (Bool | Int32 | String | Array(Hash(String, String)) | Hash(String, String)))))

  def types_file
    @types_file ||= File.read(File.expand_path("../../json/structs_and_enums.json", dir: __DIR__))
  end

  def functions_file
    @functions_file ||= File.read(File.expand_path("../../json/definitions.json", dir: __DIR__))
  end

  def well_known_types
    @well_known_types ||= {
      "bool"                   => "Bool",
      "char"                   => "LibC::Char",
      "double"                 => "LibC::Double",
      "float"                  => "LibC::Float",
      "int"                    => "LibC::Int",
      "long"                   => "LibC::Long",
      "short"                  => "LibC::Short",
      "size_t"                 => "LibC::SizeT",
      "void"                   => "Void",
      "unsigned char"          => "LibC::UChar",
      "unsigned int"           => "LibC::UInt",
      "unsigned long"          => "LibC::ULong",
      "unsigned short"         => "LibC::UShort",
      "ImWchar"                => "LibC::UShort",
      "ImVec2"                 => "ImVec2",
      "ImVec2_Simple"          => "ImVec2",
      "ImVec3"                 => "Vector3",
      "ImVec4"                 => "ImVec4",
      "ImVec4_Simple"          => "ImVec4",
      "ImColor_Simple"         => "ImColor",
      "ImTextureID"            => "Void*",
      "ImGuiID"                => "LibC::UInt",
      "ImDrawIdx"              => "LibC::UShort",
      "ImDrawListSharedData"   => "Void*",
      "ImDrawListSharedData*"  => "Void*",
      "ImU32"                  => "LibC::UInt",
      "ImDrawCallback"         => "(ImDrawList*, ImDrawCmd* ->)",
      "ImGuiInputTextCallback" => "Void*",
      "ImGuiSizeCallback"      => "Void*",
      "ImGuiContext*"          => "Void",
      "float&"                 => "LibC::Float*",
      "T"                      => "Void*",
      "T*"                     => "Void", # "char* []" => "LibC::Char**",
    }
  end

  def legal_types
    @legal_types ||= well_known_types.invert.as(Hash(String, String))
  end

  def custom_defined_types
    @custom_defined_types ||= {
      "ImVector" => true,
      "ImVec2"   => true,
      "ImVec4"   => true,
      "Pair"     => true,
    }
  end

  def enums
    @enums ||= EnumData.from_json(types_file).enum_defs.as(Array(EnumDefinition))
  end

  def types
    @types ||= TypeData.init(enums).from_json(types_file).type_defs.as(Array(TypeDefinition))
  end

  def functions_json
    @functions_json ||= FunctionJSON.from_json(functions_file)
  end

  def function_definitions
    @function_definitions ||= functions_json.map { |name, overloads|
      non_udt_variants = overloads.any? { |o| o["ov_cimguiname"]?.try(&.to_s.ends_with?("nonUDT")) }
      FunctionDefinition.new(
        name,
        overloads.each_with_object([] of OverloadDefinition) { |overload, defs|
          ov_cimguiname = overload["ov_cimguiname"]?.to_s
          cimguiname = overload["cimguiname"]?.to_s
          friendly_name = overload["funcname"]?.try(&.to_s)
          friendly_name = "destroy" if cimguiname.ends_with?("_destroy")
          next unless friendly_name
          exported_name = ov_cimguiname
          exported_name = cimguiname if exported_name.empty?
          next if non_udt_variants && !exported_name.ends_with?("nonUDT2")
          underscore_pos = exported_name.index('_')
          fix_function_name = underscore_pos.not_nil! > 0 && !exported_name.starts_with?("ig") if underscore_pos
          # self_type_name = exported_name[0...underscore_pos.not_nil!] if fix_function_name
          parameters = overload["argsT"].as(Array(Hash(String, String))).map { |arg|
            TypeReference.new(
              arg["name"].to_s,
              arg["type"].to_s,
              nil,
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
          is_constructor = overload.has_key?("constructor")
          is_destructor = overload.has_key?("destructor")
          defs << OverloadDefinition.new(
            exported_name,
            friendly_name,
            (ov_cimguiname.empty? ? cimguiname : ov_cimguiname),
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

  def generate_functions
    function_definitions.each do |fd|
      fd.overloads.each do |overload|
        exported_name = overload.raw_name.sub("ig", "")
        next if exported_name.includes?('~')
        next if exported_name.ends_with?("_const")
        next if overload.params.any?(&.function_pointer?)
        has_va_list = false
        overload.params.each do |param|
          next if param.name == "..."
          param_type = type_string(param.type, param.function_pointer?)
          if param_type == "va_list"
            has_va_list = true
            break
          end
        end
        next if has_va_list

        func_sig = "fun #{overload.raw_name.underscore} = #{overload.function_name}("

        func_sig = func_sig + overload.params.reduce([] of String) { |params, param|
          params.tap { |p| p << "#{param.name} : #{type_string(param.type, param.function_pointer?)}" unless param.name == "..." }
        }.join(", ")
        func_sig = func_sig + ")"
        # func_sig = func_sig + " : #{overload.struct_name}*" if overload.constructor?
        func_sig = func_sig + " : #{type_string(overload.return_type, false)}" unless overload.return_type.nil? || overload.return_type == "void"

        code_writer.write(func_sig)
      end
    end
  end

  def output_path
    @output_path ||= File.expand_path("../crimgui/lib3.cr", dir: __DIR__)
  end

  def code_writer
    @code_writer ||= CodeWriter.new(output_path)
  end

  def generate
    code_writer.write("require \"./custom\"")
    code_writer.write("")
    code_writer.write("@[Link(\"cimgui\")]")
    code_writer.begin_block("lib LibImGui")
    code_writer.write("# aliases")
    generate_aliases
    code_writer.write("")
    code_writer.write("# enums")
    generate_enums
    code_writer.write("# types")
    generate_types
    code_writer.write("")
    code_writer.write("# functions")
    generate_functions
    code_writer.end_block
    code_writer.finish
  end

  def generate_enums
    enums.each do |enum_def|
      code_writer.write("@[Flags]") if enum_def.flag?
      code_writer.begin_block("enum #{enum_def.name}")
      enum_def.members.each do |member|
        code_writer.write("#{member.name} = #{member.value}")
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
        if field.array_size && legal_types[type_str]
          code_writer.write("#{field.name} : #{type_str}[#{field.array_size}]")
        elsif type_str
          code_writer.write("#{field.name} : #{type_str}")
        end
      end
      code_writer.end_block
      code_writer.write("")
    end
  end

  def type_string(type_name, is_function_pointer)
    array_size = type_name.match(/\[(\d+)\]/).try &.[1]
    type_name = type_name.split('[').first
    type_str = nil
    ptr_level = 0
    while type_name[-1 * ptr_level - 1] == '*'
      ptr_level += 1
    end
    type_str ||= well_known_types[type_name]?
    type_str ||= well_known_types[type_name[0...-ptr_level]]? if ptr_level > 0
    type_str = type_str.not_nil! + "*" * ptr_level if type_str && ptr_level > 0
    type_str ||= type_str.nil? && is_function_pointer ? "Void*" : type_name.rchop('&')
    type_str += "[#{array_size}]" if array_size
    type_str
  end

  def generate_aliases
    code_writer.write("alias ImDrawIdx = LibC::UShort")
    code_writer.write("alias ImWchar = LibC::UShort")
  end
end

# Code gen

class CodeWriter
  property path : String
  property file : File?
  property indent : Int32

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
  property raw_name : String
  property name : String?
  property members : Array(EnumMember)

  def initialize(@raw_name : String, @members : Array(EnumMember))
  end

  def name
    @name ||= raw_name.rchop("_")
  end

  def flag?
    raw_name.includes?("Flags")
  end
end

class EnumMember
  property def_name : String
  property name : String?
  property raw_name : String
  property value : String?
  property raw_value : String

  def initialize(@def_name : String, @raw_name : String, @raw_value : String)
  end

  def name
    @name ||= raw_name.lchop(def_name).rchop("_").lchop("_")
  end

  def value
    @value ||= raw_value.gsub(def_name, "").rchop("_")
  end
end

class EnumData
  include JSON::Serializable

  @[JSON::Field(key: "enums", converter: EnumParser)]
  property enum_defs : Array(EnumDefinition)
end

module EnumParser
  def self.from_json(pull : JSON::PullParser)
    ([] of EnumDefinition).tap do |enum_defs|
      pull.read_object do |enum_name|
        ([] of EnumMember).tap do |enum_members|
          pull.read_array do
            ename = evalue = ""
            pull.read_object do |enum_prop|
              case enum_prop
              when "calc_value"
                pull.read_int
              when "name"
                ename = pull.read_string
              when "value"
                evalue = pull.read?(String) || pull.read?(Int32).to_s || ""
              end
            end
            enum_members << EnumMember.new(enum_name, ename, evalue)
          end
          enum_defs << EnumDefinition.new(enum_name, enum_members)
        end
      end
    end
  end
end

class TypeDefinition
  property name, fields

  def initialize(@name : String, @fields : Array(TypeReference))
  end
end

class TypeReference
  include CRZ

  property raw_name : String
  property raw_type : String
  property name : String?
  property type : String?
  property array_size : Int32?
  property template_type : String?
  property enums : Array(EnumDefinition)

  def initialize(
    @raw_name : String,
    @raw_type : String,
    @array_size : Int32?,
    @template_type : String?,
    @enums : Array(EnumDefinition)
  )
  end

  def name
    @name ||= array_size == -1 ? raw_name.underscore : raw_name.split('[').first.underscore
  end

  def type
    @type ||= chain raw_type, remove_const, remove_underscore, remove_spaces, remove_empty_brackets
  end

  def remove_const(str)
    str.gsub("const", "").strip
  end

  def remove_underscore(str)
    str.index("ImVector_") == 0 ? (str[-1] == '*' ? "ImVector*" : "ImVector") : str
  end

  def remove_spaces(str)
    str.includes?("unsigned") ? str : str.gsub(/\s/, "")
  end

  def remove_empty_brackets(str)
    str.gsub(/\[\]/, "*")
  end

  def function_pointer?
    type.includes?('(')
  end
end

class TypeData
  include JSON::Serializable

  @@enum_defs = [] of EnumDefinition

  @[JSON::Field(key: "structs", converter: TypeParser.init(@@enum_defs))]
  property type_defs : Array(TypeDefinition)

  def self.init(@@enum_defs : Array(EnumDefinition))
    self
  end
end

module TypeParser
  @@enum_defs = [] of EnumDefinition

  def self.init(@@enum_defs : Array(EnumDefinition))
    self
  end

  def self.from_json(pull : JSON::PullParser)
    ([] of TypeDefinition).tap do |type_defs|
      pull.read_object do |type_name|
        ([] of TypeReference).tap do |type_refs|
          pull.read_array do
            rname = rtype = ""
            size = temp_type = nil
            pull.read_object do |type_prop|
              case type_prop
              when "name"
                rname = pull.read_string
              when "template_type"
                temp_type = pull.read?(String)
              when "size"
                size = pull.read?(Int32)
              when "type"
                rtype = pull.read_string
              end
            end
            type_refs << TypeReference.new(rname, rtype, size, temp_type, @@enum_defs) unless rtype.includes?("static")
          end
          type_defs << TypeDefinition.new(type_name, type_refs)
        end
      end
    end
  end
end

class FunctionDefinition
  property name, overloads

  def initialize(@name : String, @overloads : Array(OverloadDefinition))
  end
end

class OverloadDefinition
  property raw_name : String
  property name : String
  property function_name : String
  property params : Array(TypeReference)
  property default_values : Hash(String, String)
  property raw_return_type : String
  property return_type : String?
  property struct_name : String
  property comment : String
  property is_constructor : Bool
  property is_destructor : Bool

  def initialize(
    @raw_name : String,
    @name : String,
    @function_name : String,
    @params : Array(TypeReference),
    @default_values : Hash(String, String),
    @raw_return_type : String,
    @struct_name : String,
    @comment : String,
    @is_constructor : Bool,
    @is_destructor : Bool
  )
  end

  def return_type
    @return_type ||= if constructor?
                       chain(struct_name, remove_vector_type, add_ptr)
                     else
                       chain(raw_return_type, remove_const, remove_inline).strip
                     end
  end

  def remove_const(str)
    str.sub("const", "")
  end

  def remove_inline(str)
    str.sub("inline", "")
  end

  def remove_vector_type(str)
    str.includes?("ImVector_") ? "ImVector" : str
  end

  def add_ptr(str)
    str.ends_with?('*') ? str : str + '*'
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
  property type : String
  property is_pinned : Bool
  property var_name : String
  property has_default_value : Bool
  property pin_target : String?

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

puts gen.generate
