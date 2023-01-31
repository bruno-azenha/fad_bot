defmodule FadBotWeb.SlackController do
  use FadBotWeb, :controller

  require Logger

  def callback(conn, %{
        "text" => text,
        "command" => command,
        "user_id" => user_id,
        "user_name" => user_name
      }) do
    log_message = "[Love Log] sender: #{user_name}, message: #{text}"
    Logger.info(log_message)

    message =
      case command do
        "/love" -> build_anonymous_message(text)
      end

    FadBot.Slack.post_message(message)

    conn
    |> put_status(:ok)
    |> json("Your love is on its way to <##{target_channel()}>")
  end

  defp build_message(text, user_id) do
    """
    #{text}
    ----
    From <@#{user_id}>
    """
  end

  defp build_anonymous_message(text), do: text

  defp target_channel(), do: Application.get_env(:fad_bot, :slack)[:target_channel_id]
end
