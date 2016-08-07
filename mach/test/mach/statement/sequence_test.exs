defmodule Mach.Statement.SequenceTest do
  use ExUnit.Case
  alias Mach.Statement.Sequence
  alias Mach.Statement.Assign
  alias Mach.Number
  alias Mach.Add
  alias Mach.Variable
  doctest Sequence

  test "#to_string simple call" do
    statement = %Sequence{
      first: %Assign{name: :x, expression: %Number{value: 1}},
      second: %Assign{name: :y, expression: %Number{value: 2}}
    }

    assert String.Chars.to_string(statement) == """
    x = 1
    y = 2
    """
  end

  test "#to_string with recursice call" do
    statement = %Sequence{
      first: %Assign{name: :x, expression: %Number{value: 1}},
      second: %Sequence{
        first: %Assign{name: :y, expression: %Number{value: 2}},
        second: %Assign{
          name: :z,
          expression: %Add{
            left: %Variable{name: :x},
            right: %Variable{name: :y}
          }
        }
      }
    }

    assert String.Chars.to_string(statement) == """
    x = 1
    y = 2
    z = [x] + [y]
    """
  end
end
