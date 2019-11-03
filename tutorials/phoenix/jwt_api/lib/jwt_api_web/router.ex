defmodule JwtApiWeb.Router do
  use JwtApiWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug JwtApiWeb.Auth.Pipeline
  end

  scope "/api", JwtApiWeb do
    pipe_through :api
    post "/users/signup", UserController, :create
    post "/users/signin", UserController, :signin
    resources "/users", UserController, except: [:new, :edit]
  end

  scope "/api", JwtApiWeb do
    pipe_through [:api, :auth]
    resources "/businesses", BusinessController, except: [:new, :edit]
  end

  pipeline :browser do
    plug :accepts, ["html"]
  end

  scope "/", JwtApiWeb do
    pipe_through :browser
    get "/", DefaultController, :index
  end
end
