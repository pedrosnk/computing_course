defmodule Mach.LessThan do
  defstruct [left: nil, right: nil, _reducible?: true]

  alias Mach.Boolean

  @doc """
  reduce an expression and returns an boolean if it is
  the smalest version of the comparation

    iex(1)> Mach.LessThan.reduce(%{}, %Mach.LessThan{
    iex(1)>   left: %Mach.Number{value: 3},
    iex(1)>   right: %Mach.Number{value: 2},
    iex(1)> })
    %Mach.Boolean{value: false}
  """
  def reduce env, %{left: %{_reducible?: true}} = op do
    reduced_left = op.left.__struct__.reduce env, op.left
    %Mach.LessThan{left: reduced_left, right: op.right}
  end

  def reduce env, %{right: %{_reducible?: true}} = op do
    reduced_right = op.right.__struct__.reduce env, op.right
    %Mach.LessThan{left: op.left, right: reduced_right}
  end

  def reduce _env, %{left: left, right: right} do
    %Boolean{value: left.value < right.value}
  end

end

defimpl String.Chars, for: Mach.LessThan do
  def to_string less_than do
    left = String.Chars.to_string less_than.left
    right = String.Chars.to_string less_than.right
    "#{left} < #{right}"
  end
end
