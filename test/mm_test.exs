defmodule MMTest do
  use ExUnit.Case
  doctest MM

  test "greets the world" do
    assert MM.hello() == :world
  end
end
