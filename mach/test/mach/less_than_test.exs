defmodule Mach.LessThanTest do
  use ExUnit.Case
  alias Mach.LessThan
  alias Mach.Number
  doctest LessThan

  test "#to_string" do
    add = %LessThan{
      left: %Number{value: 1},
      right: %Number{value: 2},
    }
    assert String.Chars.to_string(add) == "1 < 2"
  end
end
