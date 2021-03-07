Mox.defmock(FadBot.Slack.TestHost, for: FadBot.Slack.Client.Host)

defmodule FadBot.SlackHelpers do
  def bypass_slack() do
    bypass = Bypass.open()
    url = "http://localhost:#{bypass.port}"
    Mox.expect(FadBot.Slack.TestHost, :slack_url, fn -> url end)
    bypass
  end
end
