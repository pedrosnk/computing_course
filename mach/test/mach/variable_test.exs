defmodule Mach.VariableTest do
  use ExUnit.Case
  alias Mach.Variable
  alias Mach.Number
  doctest Variable

  test "#to_string" do
    variable = %Variable{name: "name"}
    assert String.Chars.to_string(variable) == "[name]"
  end

end
