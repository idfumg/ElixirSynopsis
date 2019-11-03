defmodule PasswordLockTest do
  use ExUnit.Case
  doctest PasswordLock

  setup do
    {:ok, pid} = PasswordLock.start_link("foo")
    {:ok, server: pid}
  end

  test "unlock success test", %{server: pid} do
    assert :ok == PasswordLock.unlock(pid, "foo")
  end

  test "unlock failure test", %{server: pid} do
    assert {:error, "Wrong password!"} == PasswordLock.unlock(pid, "bar")
  end

  test "reset success test", %{server: pid} do
    assert :ok == PasswordLock.reset(pid, {"foo", "bar"})
  end

  test "reset failure test", %{server: pid} do
    assert {:error, "Wrong password!"} == PasswordLock.reset(pid, {"bar", "foo"})
  end
end
