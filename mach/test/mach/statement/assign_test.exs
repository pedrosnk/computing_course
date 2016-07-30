defmodule Mach.Statement.AssignTest do
  use ExUnit.Case
  alias Mach.Statement.Assign
  doctest Assign

  test "#to_string" do
    assign = %Assign{
      name: "x",
      expression: %Mach.Add{
        left: %Mach.Number{value: 2},
        right: %Mach.Number{value: 3},
      },
    }

    assert String.Chars.to_string(assign) == "x = 2 + 3"
  end

end
