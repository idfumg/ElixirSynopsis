defmodule JwtApiWeb.DefaultController do
  use JwtApiWeb, :controller

  def index(conn, _params) do
    text conn, "JwtApi!"
  end
end
