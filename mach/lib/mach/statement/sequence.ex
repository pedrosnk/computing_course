defmodule Mach.Statement.Sequence do
  alias Mach.Statement.DoNothing
  defstruct [
    first: %DoNothing{},
    second: %DoNothing{},
    _reducible?: true
  ]

  @doc """
  This module is used to sotre a sequence output

    iex(1)> Mach.Statement.Sequence.reduce(%{}, %Mach.Statement.Sequence{
    iex(1)>   first: %Mach.Statement.DoNothing{},
    iex(1)>   second: %Mach.Statement.Assign{
    iex(1)>     name: :x,
    iex(1)>     expression: %Mach.Number{value: 5}
    iex(1)>   }
    iex(1)> })
    { %{},
      %Mach.Statement.Sequence{
        first: %Mach.Statement.Assign{
          name: :x,
          expression: %Mach.Number{value: 5}
        }
      }
    }
  """
  def reduce(env, %{first: %{_reducible?: true}} = statement)do
    reduced_statement = statement.first.__struct__.reduce(env, statement.first)
    {env, %Mach.Statement.Sequence{statement | first: reduced_statement}}
  end

  def reduce(env, %{second: %{_reducible?: true}} = statement)do
    {env, %Mach.Statement.Sequence{
      statement | first: statement.second, second: %DoNothing{}
    }}
  end

  def reduce(env, %{first: %{} = %DoNothing{}} = statement) do
    {env, statement.second}
  end

end

defimpl String.Chars, for: Mach.Statement.Sequence do
  def to_string statement do
    "#{statement.first}\n#{statement.second}\n"
    |> String.replace(~r/\n(\n)+/, "\n")
  end
end
