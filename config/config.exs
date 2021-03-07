# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :fad_bot, FadBotWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "k6iPj0dsdZnz+wNfUcijPxOq5TyYK6oZ0wpWt/72SKux9HXJix/5nmeXUFXmveGc",
  render_errors: [view: FadBotWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: FadBot.PubSub,
  live_view: [signing_salt: "UPcV9JMI"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Config Slack Host
config :fad_bot, :slack,
  host: FadBot.Slack.Client.ProdHost,
  api_token: "xoxb-1014088253766-1836173074228-Ib0Jz3E5T72kUh95DbFq5Eym"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
