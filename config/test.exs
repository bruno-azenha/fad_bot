use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fad_bot, FadBotWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Config Slack Host
config :fad_bot, :slack,
  host: FadBot.Slack.TestHost,
  api_token: "<FAKE_TOKEN>"
