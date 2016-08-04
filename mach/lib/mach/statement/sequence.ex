defmodule Mach.Statement.Sequence do
  alias Mach.Statement.DoNothing
  defstruct [
    left: %DoNothing{},
    right: %DoNothing{},
    _reducible?: true
  ]

  def reduce env, statment do
    {env, statment}
  end

end
