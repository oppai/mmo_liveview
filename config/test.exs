use Mix.Config

# Configure your database
config :mmo_liveview, MmoLiveview.Repo,
  username: "postgres",
  password: "postgres",
  database: "mmo_liveview_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :mmo_liveview, MmoLiveviewWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
