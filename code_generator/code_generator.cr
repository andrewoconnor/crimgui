require "json"

class CodeGenerator
  def types_file
    @types_file ||= File.read("json/structs_and_enums.json")
  end

  def types_json
    @types_json ||= JSON.parse(types_file)
  end

  def well_known_types
    {
      "bool"                  => "Bool",
      "unsigned char"         => "LibC::UChar",
      "char"                  => "LibC::Char",
      "ImWchar"               => "LibC::UShort",
      "unsigned short"        => "LibC::UShort",
      "unsigned int"          => "LibC::UInt",
      "ImVec2"                => "?",
      "ImVec2_Simple"         => "?",
      "ImVec3"                => "?",
      "ImVec4"                => "?",
      "ImVec4_Simple"         => "?",
      "ImColor_Simple"        => "ImColor",
      "ImTextureID"           => "Void*",
      "ImGuiID"               => "LibC::UInt",
      "ImDrawIdx"             => "LibC::UShort",
      "ImDrawListSharedData"  => "Void*",
      "ImDrawListSharedData*" => "Void*",
      "ImU32"                 => "LibC::UInt",
      "ImDrawCallback"        => "Void*",
      "size_t"                => "LibC::SizeT",
      "ImGuiContext*"         => "Void*",
      "float[2]"              => "?",
      "float[3]"              => "?",
      "float[4]"              => "?",
      "int[2]"                => "LibC::Int*",
      "int[3]"                => "LibC::Int*",
      "int[4]"                => "LibC::Int*",
      "float&"                => "LibC::Float*",
      "ImVec2[2]"             => "?",
      "char* []"              => "LibC::Char**",

      # TODO: These shouldn't exist

      "ImVector_ImWchar"    => "ImVector",
      "ImVector_TextRange"  => "ImVector",
      "ImVector_TextRange&" => "ImVector",
    }
  end
end

gen = CodeGenerator.new
p gen.types_json["enums"]

puts "\n\n\n"

p gen.well_known_types
