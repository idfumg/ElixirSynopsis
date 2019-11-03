defmodule JwtApiWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline, otp_app: :jwt_api,
    module: JwtApiWeb.Auth.Guardian,
    error_handler: JwtApiWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader
  plug Guardian.Plug.EnsureAuthenticated
  plug Guardian.Plug.LoadResource
end
