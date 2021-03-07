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

      text = "text"
      channel = "C1234567890"
      assert Slack.post_message(text, channel) == :ok
    end
  end

  describe "public_channels/0" do
    test "should list all public channels" do
      Bypass.expect(bypass_slack(), fn conn ->
        {:ok, _body, _conn} = Plug.Conn.read_body(conn)

        assert ["Bearer " <> _] = Plug.Conn.get_req_header(conn, "authorization")
        assert conn.method == "GET"
        Plug.Conn.resp(conn, 200, ~s/{"ok": true, "channels": []}/)
      end)

      assert Slack.public_channels() == {:ok, []}
    end
  end
end
