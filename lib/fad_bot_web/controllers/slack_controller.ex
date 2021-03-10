defmodule FadBotWeb.SlackController do
  use FadBotWeb, :controller

  require Logger

  def callback(conn, %{"text" => text, "command" => command, "user_id" => user}) do
    message =
      case command do
        "fad" -> build_message(text, user)
        "fad-anon" -> build_anonymous_message(text)
      end

    FadBot.Slack.post_message(message)

    conn
    |> put_status(:ok)
    |> json("Your appreciation is on its way to <##{target_channel}>")
  end

  defp build_message(text, user) do
    """
    #{text}
    ----
    From <@#{user}>
    """
  end

  defp build_anonymous_message(text), do: text

  defp target_channel(), do: Application.get_env(:fad_bot, :slack)[:target_channel_id]
end
