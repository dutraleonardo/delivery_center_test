# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :delivery_center_test,
  ecto_repos: [DeliveryCenterTest.Repo]

# Configures the endpoint
config :delivery_center_test, DeliveryCenterTestWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "gzo26gdyF6o/w5Ej5/7N2anCBP62dVZIfkDVmVO2Uoi6CIFiCSvQtTM6YZ9UHjkL",
  render_errors: [view: DeliveryCenterTestWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: DeliveryCenterTest.PubSub,
  live_view: [signing_salt: "nqLWv+4J"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
