defmodule Mach.Variable do
  defstruct [name: nil]

  @doc """
  Reducible operation that given an env it reduce to the right value that the
  variable is storing
  """
  def reducible?, do: true

  @doc """
  Given a variable, reduce to the correct value that is been held

    iex(1)> Mach.Variable.reduce(
    iex(1)>   %{foo: %Mach.Number{value: 1}},
    iex(1)>   %Mach.Variable{name: :foo}
    iex(1)> )
    %Mach.Number{value: 1}

  """
  def reduce(env, %Mach.Variable{name: name}), do: env[name]
end

defimpl String.Chars, for: Mach.Variable do
  def to_string variable do
    "[#{variable.name}]"
  end
end
