defmodule Mach.Number do
  defstruct [value: 0, _reducible?: false]

end

defimpl String.Chars, for: Mach.Number do
  def to_string number do
    Integer.to_string number.value
  end
end
