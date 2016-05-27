defmodule Mach.MultiplyTest do
  use ExUnit.Case
  alias Mach.Multiply
  alias Mach.Number
  doctest Multiply

  test "#to_string" do
    multiply = %Multiply{
      left: %Number{value: 1},
      right: %Number{value: 2},
    }
    assert String.Chars.to_string(multiply) == "1 * 2"
  end
end
