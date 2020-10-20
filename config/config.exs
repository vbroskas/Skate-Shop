# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :skate_shop,
  ecto_repos: [SkateShop.Repo]

# Configures the endpoint
config :skate_shop, SkateShopWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "WbPDIAE4KKfr9K7SVUXo3WgvZXIBjEZoTk6RwkCbvWpEmOJgh+lJYgG91wURhhP8",
  render_errors: [view: SkateShopWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: SkateShop.PubSub,
  live_view: [signing_salt: "iwR1moPo"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
