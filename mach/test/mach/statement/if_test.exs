defmodule Mach.Statement.IfTest do
  use ExUnit.Case
  alias Mach.Statement.If
  alias Mach.Statement.Assign
  alias Mach.Statement.DoNothing
  alias Mach.GreaterThan
  alias Mach.LessThan
  alias Mach.Add
  alias Mach.Multiply
  alias Mach.Number
  alias Mach.Boolean
  alias Mach.Variable
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

  test "Mach.run with truth statement" do
    statement = %If{
      condition: %Variable{name: :should_run},
      consequence: %Assign{
        name: :x,
        expression: %Add{
          left: %Number{value: 4}, right: %Number{value: 3}
        }
      },
      alternative: %Assign{
        name: :x,
        expression: %Multiply{
          left: %Number{value: 5}, right: %Number{value: 10}
        }
      }
    }
    initial_env = %{should_run: %Boolean{value: true}}
    {env, %DoNothing{}} = Mach.run_statement(initial_env, statement)
    assert env[:x] == %Number{value: 7}
    assert env[:should_run] == %Boolean{value: true}
    # reassign initial_env and try to recover diferent results from if statment
    initial_env = %{should_run: %Boolean{value: false}}
    {env, %DoNothing{}} = Mach.run_statement(initial_env, statement)
    assert env[:x] == %Number{value: 50}
    assert env[:should_run] == %Boolean{value: false}
  end

end
