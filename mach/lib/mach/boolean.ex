defmodule Mach.Boolean do
  defstruct [value: true, _reducible: false]

end

defimpl String.Chars, for: Mach.Boolean do
  def to_string boolean do
    Atom.to_string boolean.value
  end
end
