defmodule EmailSender.EmailTest do
  use ExUnit.Case
  use Bamboo.Test

  test "create" do
    email = SirenaEmail.Email.create_email()
    SirenaEmail.Mailer.deliver_now(email)
    assert email.to == "hello@elixircasts.io"
    assert email.subject == "Movie Added"
    assert email.html_body =~ "A movie was added."
  end
end
