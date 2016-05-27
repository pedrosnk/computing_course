defmodule Mach.Number do
  defstruct [value: 0]

  @doc """
  Number is not reducible it's possible to just use it's
  value
  """
  def reducible? do
    false
  end
end

defimpl String.Chars, for: Mach.Number do
  def to_string number do
    Integer.to_string number.value
  end
end
