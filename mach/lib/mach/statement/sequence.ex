defmodule Mach.Statement.Sequence do
  alias Mach.Statement.DoNothing
  defstruct [
    first: %DoNothing{},
    second: %DoNothing{},
    _reducible?: true
  ]

  def reduce env, %{first: {:_reducible?: true}} = statement do
    reduced_statement = statement.first.__struct__.reduce(env, statement.first)
    {env, %Sequence{statement | first: reduced_statement}}
  end

  def reduce env, %{second: {:_reducible?: true}} = statement do
    {env, %Sequence{statement | first: statement.second, second: %DoNothing{}}}
  end

end
