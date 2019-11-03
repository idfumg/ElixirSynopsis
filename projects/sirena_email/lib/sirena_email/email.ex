defmodule SirenaEmail.Email do
  import Bamboo.Email

  def create_email(%{"from" => from, "to" => to, "subject" => subject, "text_body" => text_body}) do
    new_email(
      from: from,
      to: to,
      subject: subject,
      text_body: text_body,
      html_body: text_body
    )
  end
end
