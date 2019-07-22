defmodule RestServerTest do
  use ExUnit.Case
  doctest RestServer

  test "greets the world" do
    assert RestServer.hello() == :world
  end
end
