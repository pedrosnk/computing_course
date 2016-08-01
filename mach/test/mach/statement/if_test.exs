defmodule Mach.Statement.IfTest do
  use ExUnit.Case
  alias Mach.Statement.If
  alias Mach.Statement.Assign
  alias Mach.Statement.DoNothing
  alias Mach.GreaterThan
  alias Mach.LessThan
  alias Mach.Number
  doctest If

  test "#to_string simple call" do
    statement = %If{
      condition: %GreaterThan{
        left: %Number{value: 2},
        right: %Number{value: 3},
      }
    }

    assert String.Chars.to_string(statement) == "if (2 > 3) { do-nothing }"
  end

  test "#to_string with else" do
    statement = %If{
      condition: %LessThan{
        left: %Number{value: 2},
        right: %Number{value: 3},
      },
      consequence: %Assign{name: :x, expression: %Number{value: 4}},
      alternative: %Assign{name: :x, expression: %Number{value: 5}}
    }

    assert String.Chars.to_string(statement) == 
      "if (2 < 3) { x = 4 } else { x = 5 }"
  end
end
