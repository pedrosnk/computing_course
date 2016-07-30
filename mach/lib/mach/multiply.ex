defmodule Mach.Multiply do
  defstruct [left: nil, right: nil, _reducible?: true]

  alias Mach.Number

  @doc """
  reduce a multiply operation to a number multiplying
  the values from the left side to the right side

    iex(1)> Mach.Multiply.reduce(%{}, %Mach.Multiply{
    iex(1)> left: %Mach.Number{value: 2},
    iex(1)> right: %Mach.Number{value: 3},
    iex(1)> })
    %Number{value: 6}

  Reduce to other operations always resolving first the left
  side
    iex(2)> Mach.Multiply.reduce(%{}, %Mach.Add{
    iex(2)>   left: %Mach.Multiply{
    iex(2)>     left: %Mach.Number{value: 1},
    iex(2)>     right: %Mach.Number{value: 2},
    iex(2)>   },
    iex(2)>   right: %Mach.Add{
    iex(2)>     left: %Mach.Number{value: 2},
    iex(2)>     right: %Mach.Number{value: 2},
    iex(2)>   }
    iex(2)> })
    %Mach.Multiply{
      left: %Mach.Number{value: 2},
      right: %Mach.Add{
        left: %Mach.Number{value: 2},
        right: %Mach.Number{value: 2},
      }
    }
  """
  def reduce env, %{left: %{_reducible?: true}} = op do
    reduced_left = op.left.__struct__.reduce env, op.left
    %Mach.Multiply{left: reduced_left, right: op.right}
  end

  def reduce env, %{right: %{_reducible?: true}} = op do
    reduced_right = op.right.__struct__.reduce env, op.right
    %Mach.Multiply{left: op.left, right: reduced_right}
  end

  def reduce _env, %{right: right, left: left} do
    %Number{value: left.value * right.value}
  end

end

defimpl String.Chars, for: Mach.Multiply do
  def to_string multiply do
    left = String.Chars.to_string multiply.left
    right = String.Chars.to_string multiply.right
    "#{left} * #{right}"
  end
end
