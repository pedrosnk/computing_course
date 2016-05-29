defmodule Mach.Add do
  defstruct [left: nil, right: nil]

  alias Mach.Number

  @doc """
  Add Operation is reducible direct to a number

    iex> Mach.Add.reducible?
    true
  """
  def reducible?, do: true

  @doc """
  reduce an add operation to a number summing the values
  from the left side to the right side

    iex(1)> Mach.Add.reduce(%Mach.Add{
    iex(1)>   left: %Mach.Number{value: 2},
    iex(1)>   right: %Mach.Number{value: 3},
    iex(1)> })
    %Number{value: 5}

  Reduce other also to other Add operations always resolving
  first the left side

    iex(2)> Mach.Add.reduce(%Mach.Add{
    iex(2)>   left: %Mach.Add{
    iex(2)>     left: %Mach.Number{value: 1},
    iex(2)>     right: %Mach.Number{value: 2},
    iex(2)>   },
    iex(2)>   right: %Mach.Add{
    iex(2)>     left: %Mach.Number{value: 2},
    iex(2)>     right: %Mach.Number{value: 2},
    iex(2)>   }
    iex(2)> })
    %Mach.Add{
      left: %Mach.Number{value: 3},
      right: %Mach.Add{
        left: %Mach.Number{value: 2},
        right: %Mach.Number{value: 2},
      }
    }
  """
  def reduce op do
    if op.left.__struct__.reducible? do
      reduced_left = op.left.__struct__.reduce op.left
      %Mach.Add{
        left: reduced_left, right: op.right
      }
    else
      if op.right.__struct__.reducible? do
        reduced_right = op.right.__struct__.reduce op.right
        %Mach.Add{
          left: op.left, right: reduced_right
        }
      else
        %Number{value: op.left.value + op.right.value}
      end
    end
  end

end

defimpl String.Chars, for: Mach.Add do
  def to_string add do
    left = String.Chars.to_string add.left
    right = String.Chars.to_string add.right
    "#{left} + #{right}"
  end
end
