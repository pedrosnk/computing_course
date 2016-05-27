defmodule Mach.GreaterThanTest do
  use ExUnit.Case
  alias Mach.GreaterThan
  alias Mach.Number
  doctest GreaterThan

  test "#to_string" do
    add = %GreaterThan{
      left: %Number{value: 1},
      right: %Number{value: 2},
    }
    assert String.Chars.to_string(add) == "1 > 2"
  end
end
