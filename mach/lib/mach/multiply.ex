defmodule Mach.Multiply do
  defstruct [left: nil, right: nil]

  alias Mach.Number

  @doc """
  Multiply Operation is reducible direct to a number

    iex> Mach.Add.reducible?
    true
  """

  def reducible? do
    true
  end

  @doc """
  reduce a multiply operation to a number multiplying
  the values from the left side to the right side

    iex(1)> Mach.Multiply.reduce(%Mach.Multiply{
    iex(1)> left: %Mach.Number{value: 2},
    iex(1)> right: %Mach.Number{value: 3},
    iex(1)> })
    %Number{value: 6}

  """
  def reduce op do
    %Number{value: op.left.value * op.right.value}
  end
end

defimpl String.Chars, for: Mach.Multiply do
  def to_string multiply do
    left = String.Chars.to_string multiply.left
    right = String.Chars.to_string multiply.right
    "#{left} * #{right}"
  end
end
