defmodule FadBot.SlackTest do
  use ExUnit.Case

  alias FadBot.Slack

  import FadBot.SlackHelpers

  describe "post_message/2" do
    test "receives a slack message struct as param" do
      Bypass.expect(bypass_slack(), fn conn ->
        {:ok, _body, _conn} = Plug.Conn.read_body(conn)

        assert ["Bearer " <> _] = Plug.Conn.get_req_header(conn, "authorization")
        Plug.Conn.resp(conn, 200, ~s/{"ok": true}/)
      end)

      message = "message"
      assert Slack.post_message(message) == :ok
    end
  end
end
