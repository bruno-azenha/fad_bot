defmodule FadBotWeb.SlackController do
  use FadBotWeb, :controller

  require Logger

  def callback(conn, %{"text" => text} = params) do
    FadBot.Slack.post_message(text)

    conn
    |> put_status(:ok)
    |> json("Your appreciation is on its way to <##{target_channel}>")
  end

  defp target_channel(), do: Application.get_env(:fad_bot, :slack)[:target_channel_id]
end
