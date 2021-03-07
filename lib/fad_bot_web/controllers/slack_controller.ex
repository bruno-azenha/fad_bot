defmodule FadBotWeb.SlackController do
  use FadBotWeb, :controller

  def callback(conn, _params) do
    conn
    |> put_status(:ok)
    |> json("Ok, sending your message")
  end
end
