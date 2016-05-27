defmodule Mach.Add do
  defstruct [left: nil, right: nil]

  alias Mach.Number

  @doc """
  Add Operation is reducible direct to a number
  
    iex> Mach.Add.reducible?
    true
  """
  def reducible? do
    true
  end

  @doc """
  reduce an add operation to a number summing the values
  from the left side to the right side

    iex(1)> Mach.Add.reduce(%Mach.Add{
    iex(1)> left: %Mach.Number{value: 2},
    iex(1)> right: %Mach.Number{value: 3},
    iex(1)> })
    %Number{value: 5}
  """
  def reduce op do
    %Number{value: op.left.value + op.right.value}
  end

end

defimpl String.Chars, for: Mach.Add do
  def to_string add do
    left = String.Chars.to_string add.left
    right = String.Chars.to_string add.right
    "#{left} + #{right}"
  end
end
