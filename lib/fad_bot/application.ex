defmodule FadBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      FadBotWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: FadBot.PubSub},
      # Start Finch HTTP server
      {Finch, name: FadBot.Finch},
      # Start the Endpoint (http/https)
      FadBotWeb.Endpoint
      # Start a worker by calling: FadBot.Worker.start_link(arg)
      # {FadBot.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FadBot.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FadBotWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
