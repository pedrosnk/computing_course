defmodule Mach.Add do
  defstruct [left: nil, right: nil, _reducible?: true]

  alias Mach.Number

  @doc """
  reduce an add operation to a number summing the values
  from the left side to the right side

    iex(1)> Mach.Add.reduce(%{}, %Mach.Add{
    iex(1)>   left: %Mach.Number{value: 2},
    iex(1)>   right: %Mach.Number{value: 3},
    iex(1)> })
    %Number{value: 5}

  Reduce other also to other Add operations always resolving
  first the left side

    iex(2)> Mach.Add.reduce(%{}, %Mach.Add{
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
  def reduce env, %{left: %{_reducible?: true}} = op do
    reduced_left = op.left.__struct__.reduce env, op.left
    %Mach.Add{left: reduced_left, right: op.right}
  end

  def reduce env, %{right: %{_reducible?: true}} = op do
    reduced_right = op.right.__struct__.reduce env, op.right
    %Mach.Add{left: op.left, right: reduced_right}
  end

  def reduce(_env, op), do: %Number{value: op.left.value + op.right.value}

end

defimpl String.Chars, for: Mach.Add do
  def to_string add do
    left = String.Chars.to_string add.left
    right = String.Chars.to_string add.right
    "#{left} + #{right}"
  end
end
