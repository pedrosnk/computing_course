defmodule Mach.Statement.DoNothing do
  defstruct [_reducible?: false]

end

defimpl String.Chars, for: Mach.Statement.DoNothing do
  def to_string _statement do
    "do-nothing"
  end
end
