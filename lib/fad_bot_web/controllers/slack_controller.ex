defmodule FadBotWeb.SlackController do
  use FadBotWeb, :controller

  require Logger

  def callback(conn, %{"text" => text} = params) do
    message = """
    Slack calback received:

        #{inspect(params)}
    """

    Logger.info(message)

    FadBot.Slack.post_message(text)

    conn
    |> put_status(:ok)
    |> json("Ok, sending your message")
  end
end
