defmodule SirenaEmailWeb.Router do
  use SirenaEmailWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", SirenaEmailWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  scope "/", SirenaEmail do
    pipe_through :api

    get "/send_email", EmailController, :send_email
  end

  if Mix.env == :dev or Mix.env == :test do
    forward "/sent_emails", Bamboo.EmailPreviewPlug
  end

  # Other scopes may use custom stacks.
  # scope "/api", SirenaEmailWeb do
  #   pipe_through :api
  # end
end
