use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sirena_email, SirenaEmailWeb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

config :sirena_email, SirenaEmail.Mailer,
  adapter: Bamboo.TestAdapter
