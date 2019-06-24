require "spec"
require "../../src/code_generator/code_generator"

describe EnumDefinition do
  describe "#name" do
    it "removes trailing underscore from raw name" do
      EnumDefinition.new("Foo_", [] of EnumMember).name.should eq "Foo"
    end

    it "does not modify raw name without trailing underscore" do
      EnumDefinition.new("Foo", [] of EnumMember).name.should eq "Foo"
    end
  end

  describe "#flag?" do
    it "returns true if name contains Flags" do
      EnumDefinition.new("ImDrawCornerFlags_", [] of EnumMember).flag?.should be_true
    end

    it "returns false if name contains Flags" do
      EnumDefinition.new("ImGuiCol_", [] of EnumMember).flag?.should be_false
    end
  end
end

describe EnumMember do
  describe "#name" do
    it "removes name prefix and leading and trailing underscores from member names" do
      EnumMember.new("Foo", "FooBar_", "").name.should eq "Bar"
    end
  end

  describe "#value" do
    it "removes name prefix and trailing underscore from member values" do
      EnumMember.new("ImDrawCornerFlags_", "ImDrawCornerFlags_Top", "ImDrawCornerFlags_TopLeft").value.should eq "TopLeft"
    end
  end
end

describe TypeReference do
  describe "#type" do
    it "removes const from type" do
      TypeReference.new("", "const char*", nil, [] of EnumDefinition).type.should eq "char*"
    end

    it "removes underscore from ImVector type" do
      TypeReference.new("", "ImVector_int", nil, [] of EnumDefinition).type.should eq "ImVector"
    end
  end

  describe "#parse_string_size" do
    it "gets size within array brackets of name" do
      array_size = TypeReference.new("InputBuf[256]", "", nil, [] of EnumDefinition).array_size
      array_size.should eq 256
    end

    it "sums sizes within array brackets of name" do
      array_size = TypeReference.new("DataType[32+1]", "", nil, [] of EnumDefinition).array_size
      array_size.should eq 33
    end
  end

  describe "#function_pointer?" do
    it "is true if type has a parentheses" do
      TypeReference.new("", "void(*)(int x,int y)", nil, [] of EnumDefinition).function_pointer?.should be_true
    end

    it "is false if type does not have parentheses" do
      TypeReference.new("", "bool", nil, [] of EnumDefinition).function_pointer?.should be_false
    end
  end
end

# describe OverloadDefinition do
#   describe "#return_type" do
#     it "removes const from type" do
#       OverloadDefinition.new(
#         "",
#         "",
#         [] of TypeReference,
#         {} of String => String,
#         "const char*",
#         "",
#         "",
#         false,
#         false
#       ).return_type.should eq "char*"
#     end

#     it "removes inline from type" do
#       OverloadDefinition.new(
#         "",
#         "",
#         [] of TypeReference,
#         {} of String => String,
#         "const char*",
#         "",
#         "",
#         false,
#         false
#       ).return_type.should eq "char*"
#     end
#   end

#   describe "#member_function?" do
#     it "is true if struct name is not empty" do
#       OverloadDefinition.new(
#         "",
#         "",
#         [] of TypeReference,
#         {} of String => String,
#         "",
#         "ImGui",
#         "",
#         false,
#         false
#       ).member_function?.should be_true
#     end

#     it "is false if struct name is empty" do
#       OverloadDefinition.new(
#         "",
#         "",
#         [] of TypeReference,
#         {} of String => String,
#         "",
#         "",
#         "",
#         false,
#         false
#       ).member_function?.should be_false
#     end
#   end
# end
