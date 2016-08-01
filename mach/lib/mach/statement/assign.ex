defmodule Mach.Statement.Assign do
  defstruct [name: nil, expression: nil, _reducible?: true]

  alias Mach.Statement.DoNothing
  alias Mach.Statement.Assign

  @doc """
  reduce an assign statemente by assigning the left side into a k-v variable

    iex(1)> Mach.Statement.Assign.reduce(%{}, %Mach.Statement.Assign{
    iex(1)>   name: :x,
    iex(1)>   expression: %Mach.Add{
    iex(1)>     left: %Mach.Number{value: 2},
    iex(1)>     right: %Mach.Number{value: 3},
    iex(1)>   },
    iex(1)> })
    { %{},
      %Mach.Statement.Assign{
        name: :x,
        expression: %Mach.Number{value: 5}
    } }

  Also test if redution returns the assignment properly merged

    iex(2)> Mach.Statement.Assign.reduce(
    iex(2)>   %{y: %Mach.Number{value: 2}, x: %Mach.Number{value: 5}},
    iex(2)>   %Mach.Statement.Assign{
    iex(2)>     name: :x,
    iex(2)>     expression: %Mach.Number{value: 5}
    iex(2)>   }
    iex(2)> )
    {
      %{y: %Mach.Number{value: 2}, x: %Mach.Number{value: 5}},
      %Mach.Statement.DoNothing{}
    }
  """
  def reduce env, %{expression: %{_reducible?: true}} = assign do
    reduced_expression = assign.expression.__struct__.reduce(env, assign.expression)
    {env, %Assign{name: assign.name, expression: reduced_expression}}
  end

  def reduce env, %{expression: %{_reducible?: false}} = assign do
    {Map.merge(env, %{assign.name => assign.expression}), %DoNothing{}}
  end
end

defimpl String.Chars, for: Mach.Statement.Assign do
  def to_string statement do
    "#{statement.name} = #{statement.expression}"
  end
end
