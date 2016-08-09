defmodule Mach.Statement.While do
  alias Mach.Statement.DoNothing
  alias Mach.Statement.Sequence
  alias Mach.Statement.If
  defstruct [
    condition: %DoNothing{}
    sequence: %Sequence{}
  ]


end

defimpl String.Chars, for: Mach.Statement.Sequence do
  def to_string statement do
    "while ( #{statement.condition} {\n#{statement.Sequence}})"
  end
end
