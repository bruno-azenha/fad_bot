defmodule FadBot.Slack do
  require Logger

  alias FadBot.Slack.Client

  @spec post_message(channel :: String.t(), message :: String.t()) :: :ok | :error
  def post_message(channel, message) do
    case Client.post_message(channel, message) do
      {:ok, _} -> :ok
      _ -> :error
    end
  end

  @spec public_channels() :: {:ok, list()} | :error
  def public_channels() do
    case Client.public_channels() do
      {:ok, %{"channels" => channels}} -> {:ok, channels}
      _ -> :error
    end
  end
end
