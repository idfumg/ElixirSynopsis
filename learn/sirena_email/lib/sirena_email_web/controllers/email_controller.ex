defmodule SirenaEmail.EmailController do
  use SirenaEmailWeb, :controller

  alias SirenaEmail.{Mailer, Email}

  def send_email(conn, params) do
    Email.create_email(params)
    |> Mailer.deliver_later()

    conn
    |> text("Email was sent")
  end
end
