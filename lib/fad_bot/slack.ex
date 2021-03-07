defmodule FadBot.Slack do
  require Logger

  alias FadBot.Slack.Client

  @spec post_message(message :: String.t()) :: :ok | :error
  def post_message(message) do
    case Client.post_message(target_channel(), message) do
      {:ok, _} -> :ok
      _ -> :error
    end
  end

  defp target_channel(), do: Application.get_env(:fad_bot, :slack)[:target_channel_id]
end
