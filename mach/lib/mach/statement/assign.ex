defmodule Mach.Statement.Assign do
  defstruct [name: nil, expression: nil]

  alias Mach.Statement.DoNothing
  alias Mach.Statement.Assign

  @doc """
  Assign statement is reducible to until it can reach do-nothing statement
  """
  def reducible?, do: true

  @doc """
  reduce an assign statemente by assigning the left side into a k-v variable

    iex(1)> Mach.Statement.Assign.reduce(%{}, %Mach.Statement.Assign{
    iex(1)>   name: "x",
    iex(1)>   expression: %Mach.Add{
    iex(1)>     left: %Mach.number{value: 2},
    iex(1)>     right: %Mach.number{value: 3},
    iex(1)>   },
    iex(1)> })
    [%{}, %Mach.number{value: 5}]
  """
  def reduce env, assign do
    if assign.expression.__struct__.reducible? do
      reduced_expression = assign.expression.__struct__.reduce(env, assign.expression)
      [env, %Assign{name: assign.name, expression: reduced_expression}]
    else
      [env,%DoNothing{}]
    end
  end
end
