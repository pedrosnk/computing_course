defmodule Mach do

  @doc """
    Run and resolve operations in series reducing each one
    of then

    iex(1)> Mach.run_single(%{}, %Mach.Multiply{
    iex(1)>   left: %Mach.Multiply{
    iex(2)>     left: %Mach.Number{value: 1},
    iex(2)>     right: %Mach.Number{value: 2},
    iex(2)>   },
    iex(1)>   right: %Mach.Add{
    iex(1)>     left: %Mach.Number{value: 2},
    iex(1)>     right: %Mach.Number{value: 2},
    iex(1)>   }
    iex(1)> })
    %Mach.Number{value: 8}

  Possible even to mach the result of the expression if
  it is a boolean evaluation

    iex(2)> Mach.run_single(%{}, %Mach.LessThan{
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
  def run env, op do
    case op.__struct__.reducible? do
      true ->
        run(env, op.__struct__.reduce(env, op))
      _ ->
        op
    end
  end

end
