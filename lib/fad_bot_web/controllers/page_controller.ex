defmodule FadBotWeb.PageController do
  use FadBotWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
