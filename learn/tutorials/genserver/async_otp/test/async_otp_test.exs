defmodule AsyncOtpTest do
  use ExUnit.Case
  doctest AsyncOtp

  test "async initialization success" do
    assert {:ok, pid} = AsyncOtp.start_link()
  end

  test "send long running task but do not stop server loop working so long" do
    assert {:ok, pid} = AsyncOtp.start_link()
    assert :result == AsyncOtp.request(pid)
  end
end
