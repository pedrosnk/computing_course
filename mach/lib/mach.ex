defmodule Mach do

  @doc """
    Run and resolve operations in series reducing each one
    of then

    iex(1)> Mach.run_op(%{}, %Mach.Multiply{
    iex(1)>   left: %Mach.Multiply{
    iex(1)>     left: %Mach.Number{value: 1},
    iex(1)>     right: %Mach.Number{value: 2},
    iex(1)>   },
    iex(1)>   right: %Mach.Add{
    iex(1)>     left: %Mach.Number{value: 2},
    iex(1)>     right: %Mach.Number{value: 2},
    iex(1)>   }
    iex(1)> })
    %Mach.Number{value: 8}

  Possible even to mach the result of the expression if
  it is a boolean evaluation

    iex(2)> Mach.run_op(%{}, %Mach.LessThan{
    iex(2)>   left: %Mach.Add{
    iex(2)>     left: %Mach.Number{value: 1},
    iex(2)>     right: %Mach.Number{value: 2},
    iex(2)>   },
    iex(2)>   right: %Mach.Add{
    iex(2)>     left: %Mach.Number{value: 2},
    iex(2)>     right: %Mach.Number{value: 2},
    iex(2)>   }
    iex(2)> })
    %Mach.Boolean{value: true}
  """
  def run_op env, %{_reducible?: true} = op do
    run_op(env, op.__struct__.reduce(env, op))
  end

  def run_op(_env, op), do: op

  @doc """
  run a single statement

    iex(1)> Mach.run_statement(%{},
    iex(1)>   %Mach.Statement.Assign{
    iex(1)>     name: :number,
    iex(1)>     expression: %Mach.Add{
    iex(1)>       left: %Mach.Number{value: 4},
    iex(1)>       right: %Mach.Number{value: 6}, 
    iex(1)>     }
    iex(1)>   }
    iex(1)> )
    {%{number: %Mach.Number{value: 10}}, %Mach.Statement.DoNothing{}}
  """
  def run_statement env, %{_reducible?: true} = statement do
    {env, statement} = statement.__struct__.reduce(env, statement)
    run_statement(env, statement)
  end

  def run_statement(env, statement), do: {env, statement}

end
