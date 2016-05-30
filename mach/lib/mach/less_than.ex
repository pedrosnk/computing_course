defmodule Mach.LessThan do
  defstruct [left: nil, right: nil]

  alias Mach.Boolean

  @doc """
  LessThan express is an reducible value
  """
  def reducible?, do: true

  @doc """
  reduce an expression and returns an boolean if it is
  the smalest version of the comparation

    iex(1)> Mach.LessThan.reduce(%{}, %Mach.LessThan{
    iex(1)>   left: %Mach.Number{value: 3},
    iex(1)>   right: %Mach.Number{value: 2},
    iex(1)> })
    %Mach.Boolean{value: false}
  """
  def reduce env, op do 
    if op.left.__struct__.reducible? do
      reduced_left = op.left.__struct__.reduce env, op.left
      %Mach.LessThan{
        left: reduced_left, right: op.right
      }
    else if op.right.__struct__.reducible? do
        reduced_right = op.right.__struct__.reduce env, op.right
        %Mach.LessThan{
          left: op.left, right: reduced_right
        }
      else
        %Boolean{value: op.left.value < op.right.value}
      end
    end
  end

end

defimpl String.Chars, for: Mach.LessThan do
  def to_string less_than do
    left = String.Chars.to_string less_than.left
    right = String.Chars.to_string less_than.right
    "#{left} < #{right}"
  end
end
