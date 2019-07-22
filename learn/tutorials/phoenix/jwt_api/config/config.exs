# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :jwt_api,
  ecto_repos: [JwtApi.Repo]

# Configures the endpoint
config :jwt_api, JwtApiWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "PQJyjM9wltxASLgqvwbg+UK2QB+yrhkKko1TBQMErhdkvVSYAEhJbUsWrES6ReFo",
  render_errors: [view: JwtApiWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: JwtApi.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

config :jwt_api, JwtApiWeb.Auth.Guardian,
  issuer: "jwt_api",
  secret_key: "MXOm+JnspolM3lZOlWOzZSFTwsvNNkUXO9Le5bJMNoIeGIgLg+/iaF2WEcm9SOzM"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
