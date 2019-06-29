# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :mmo_liveview,
  ecto_repos: [MmoLiveview.Repo]

# Configures the endpoint
config :mmo_liveview, MmoLiveviewWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "alyiS+O4DT9nBYZi9pMalxhFui75w0wvls4eeMIm8o0i6P2a8oDc63oxjhu2scB1",
  render_errors: [view: MmoLiveviewWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MmoLiveview.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :phoenix,
  template_engines: [leex: Phoenix.LiveView.Engine]

config :mmo_liveview, MmoLiveviewWeb.Endpoint,
  live_view: [
    signing_salt: "wHXxqYBsbn6ApJ5BjOHyrHFmHGlzuc3d"
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
