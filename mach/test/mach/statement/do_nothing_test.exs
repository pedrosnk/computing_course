defmodule Mach.Statement.AddTest do
  use ExUnit.Case
  alias Mach.Statement.DoNothing

  test "#to_string" do
    do_nothing = %DoNothing{}
    assert String.Chars.to_string(do_nothing) == "do-nothing"
  end

end
