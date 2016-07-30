defmodule Mach.GreaterThan do
  defstruct [left: nil, right: nil, _reducible?: true]

  alias Mach.Boolean

  @doc """
  reduce an expression and return the boolean value of
  comparation

    iex(1)> Mach.GreaterThan.reduce(%{}, %Mach.GreaterThan{
    iex(1)>   left: %Mach.Number{value: 3},
    iex(1)>   right: %Mach.Number{value: 2},
    iex(1)> })
    %Mach.Boolean{value: true}
  """
  def reduce env, %{left: %{_reducible?: true}} = op do
    reduced_left = op.left.__struct__.reduce env, op.left
    %Mach.GreaterThan{left: reduced_left, right: op.right}
  end

  def reduce env, %{right: %{_reducible?: true}} = op do
    reduced_right = op.right.__struct__.reduce env, op.right
    %Mach.GreaterThan{left: op.left, right: reduced_right}
  end

  def reduce(_env, %{left: left, right: right}) do
    %Boolean{value: left.value > right.value}
  end

end

defimpl String.Chars, for: Mach.GreaterThan do
  def to_string greater_than do
    left = String.Chars.to_string greater_than.left
    right = String.Chars.to_string greater_than.right
    "#{left} > #{right}"
  end
end
