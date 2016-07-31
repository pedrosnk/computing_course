defmodule Mach.Statement.IfTest do
  use ExUnit.Case
  alias Mach.Statement.If
  alias Mach.Statement.DoNothing
  alias Mach.GreaterThan
  doctest If

  test "#to_string" do
    statement = %If{
      condition: %GreaterThan{
        left: %Mach.Number{value: 2},
        right: %Mach.Number{value: 3},
      }
    }

    assert String.Chars.to_string(statement) == "if (2 > 3) { do-nothing }"
  end

end
