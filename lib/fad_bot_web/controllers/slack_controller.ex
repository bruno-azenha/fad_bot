defmodule FadBotWeb.SlackController do
  use FadBotWeb, :controller

  require Logger

  def callback(conn, params) do
    Logger.info("Receiving callback #{inspect(params)}")

    conn
    |> put_status(:ok)
    |> json("")
  end
end
