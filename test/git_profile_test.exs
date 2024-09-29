defmodule GitProfileTest do
  use ExUnit.Case
  doctest GitProfile

  test "greets the world" do
    assert GitProfile.hello() == :world
  end
end
