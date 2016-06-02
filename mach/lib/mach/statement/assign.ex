defmodule Mach.Statement.Assign do
  defstruct [name: nil, expression: nil]

  alias Mach.Statement.DoNothing
  alias Mach.Statement.Assign

  def reducible?, do: true

  def reduce env, assign do
    if assign.expression.__struct__.reducible? do
      reduced_expression = assign.expression.__struct__.reduce(env, assign.expression)
      [env, %Assign{name: assign.name, expression: reduced_expression}]
    else
      [env,%DoNothing{}]
    end
  end
end
