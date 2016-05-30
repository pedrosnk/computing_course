defmodule Mach.GreaterThan do
  defstruct [left: nil, right: nil]

  alias Mach.Boolean

  @doc """
  GreaterThan express is an reducible value
  """
  def reducible?, do: true

  @doc """
  reduce an expression and return the boolean value of
  comparation

    iex(1)> Mach.GreaterThan.reduce(%{}, %Mach.GreaterThan{
    iex(1)>   left: %Mach.Number{value: 3},
    iex(1)>   right: %Mach.Number{value: 2},
    iex(1)> })
    %Mach.Boolean{value: true}
  """
  def reduce env, op do 
    if op.left.__struct__.reducible? do
      reduced_left = op.left.__struct__.reduce env, op.left
      %Mach.GreaterThan{
        left: reduced_left, right: op.right
      }
    else if op.right.__struct__.reducible? do
        reduced_right = op.right.__struct__.reduce env, op.right
        %Mach.GreaterThan{
          left: op.left, right: reduced_right
        }
      else
        %Boolean{value: op.left.value > op.right.value}
      end
    end
  end

end

defimpl String.Chars, for: Mach.GreaterThan do
  def to_string greater_than do
    left = String.Chars.to_string greater_than.left
    right = String.Chars.to_string greater_than.right
    "#{left} > #{right}"
  end
end
