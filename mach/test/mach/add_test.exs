defmodule Mach.AddTest do
  use ExUnit.Case
  alias Mach.Add
  alias Mach.Number
  doctest Add

  test "#to_string" do
    add = %Add{
      left: %Number{value: 1},
      right: %Number{value: 2},
    }
    assert String.Chars.to_string(add) == "1 + 2"
  end
end
