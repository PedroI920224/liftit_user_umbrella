defmodule LiftitUserDbTest do
  use ExUnit.Case
  doctest LiftitUserDb

  test "greets the world" do
    assert LiftitUserDb.hello() == :world
  end
end
