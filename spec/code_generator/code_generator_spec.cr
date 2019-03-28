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

  describe "#sanitized_names" do
    it "removes name prefix and trailing underscore from member names" do
      sanitized_names = EnumDefinition.new("Foo", [EnumMember.new("FooBar_", "")]).sanitized_names
      sanitized_names.should eq({"FooBar_" => {"Bar" => ""}})
    end

    it "does not modify member names without name prefix or trailing underscore" do
      sanitized_names = EnumDefinition.new("", [EnumMember.new("FooBar", "")]).sanitized_names
      sanitized_names.should eq({"FooBar" => {"FooBar" => ""}})
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

describe OverloadDefinition do
  describe "#return_type" do
    it "removes const from type" do
      OverloadDefinition.new(
        "",
        "",
        [] of TypeReference,
        {} of String => String,
        "const char*",
        "",
        "",
        false,
        false
      ).return_type.should eq "char*"
    end

    it "removes inline from type" do
      OverloadDefinition.new(
        "",
        "",
        [] of TypeReference,
        {} of String => String,
        "const char*",
        "",
        "",
        false,
        false
      ).return_type.should eq "char*"
    end
  end

  describe "#member_function?" do
    it "is true if struct name is not empty" do
      OverloadDefinition.new(
        "",
        "",
        [] of TypeReference,
        {} of String => String,
        "",
        "ImGui",
        "",
        false,
        false
      ).member_function?.should be_true
    end

    it "is false if struct name is empty" do
      OverloadDefinition.new(
        "",
        "",
        [] of TypeReference,
        {} of String => String,
        "",
        "",
        "",
        false,
        false
      ).member_function?.should be_false
    end
  end
end
