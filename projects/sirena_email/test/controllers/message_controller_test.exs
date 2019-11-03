defmodule SirenaEmailWeb.MessageControllerTest do
  use SirenaEmailWeb.ConnCase
  use Bamboo.Test

  describe "create message" do
    test "email is sent when data is valid", %{conn: conn} do
      get conn, "/sent_emails"

      assert_delivered_email SirenaEmail.Email.create_email()
    end
  end

end
