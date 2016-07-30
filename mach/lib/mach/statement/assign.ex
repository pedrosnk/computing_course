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
    iex(1)>     left: %Mach.Number{value: 2},
    iex(1)>     right: %Mach.Number{value: 3},
    iex(1)>   },
    iex(1)> })
    [%{}, %Mach.Statement.Assign{
      name: "x",
      expression: %Mach.Number{value: 5}
    }]

    iex(2)> Mach.Statement.Assign.reduce(%{}, %Mach.Statement.Assign{
    iex(2)>   name: "x",
    iex(2)>   expression: %Mach.Number{value: 2}
    iex(2)> })
    [%{"x" => %Mach.Number{value: 2}}, %Mach.Statement.DoNothing{}]
  """
  def reduce env, assign do
    if assign.expression.__struct__.reducible? do
      reduced_expression = assign.expression.__struct__.reduce(env, assign.expression)
      [env, %Assign{name: assign.name, expression: reduced_expression}]
    else
      [Map.merge(env, %{assign.name => assign.expression}), %DoNothing{}]
    end
  end
end

defimpl String.Chars, for: Mach.Statement.Assign do
  def to_string statement do
    "#{statement.name} = #{statement.expression}"
  end
end
