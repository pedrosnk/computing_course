defmodule Mach.Statement.If do
  alias Mach.Statement.DoNothing
  alias Mach.Boolean

  defstruct [
    condition: %Boolean{value: true},
    consequence: %DoNothing{},
    alternative: %DoNothing{},
    _reducible?: true
  ]

  @doc """
  Reduce conditional statements

    iex(1)> Mach.Statement.If.reduce(
    iex(1)>   %{},
    iex(1)>   %Mach.Statement.If{
    iex(1)>     condition: %Mach.LessThan{
    iex(1)>       left: %Mach.Number{value: 4},
    iex(1)>       right: %Mach.Number{value: 5},
    iex(1)>     }
    iex(1)>   }
    iex(1)> )
    {%{}, %Mach.Statement.If{condition: %Mach.Boolean{value: true}}}
  """
  def reduce(env, %{condition: %{_reducible?: true}} = statement) do
    condition = statement.condition
    reduced_condition = condition.__struct__.reduce(env, condition)
    {env, %Mach.Statement.If{statement | condition: reduced_condition}}
  end

  def reduce(env, %{condition: %Boolean{value: true}} = statement ) do
    {env, statement.consequence}
  end

  def reduce(env, %{condition: %Boolean{value: false}} = statement) do
    {env, statement.alternative}
  end

end

defimpl String.Chars, for: Mach.Statement.If do
  def to_string statement do
    "if (#{statement.condition}) { #{statement.consequence} }"
  end
end
