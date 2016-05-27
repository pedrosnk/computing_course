defmodule Mach.Boolean do
  defstruct [value: true]

  @doc """
  Boolean is not a reduciable operation
  """
  def reducible?, do: false
end

defimpl String.Chars, for: Mach.Boolean do
  def to_string boolean do
    Atom.to_string boolean.value
  end
end
