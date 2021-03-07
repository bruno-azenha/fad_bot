defmodule FadBot.Slack.Client do
  @moduledoc """
  Interface to Slack API.
  """

  defmodule Host do
    @callback slack_url() :: String.t()
  end

  defmodule ProdHost do
    @behaviour Host

    @impl true
    def slack_url(), do: "https://slack.com/api"
  end

  require Logger

  def post_message(channel, message) do
    body = %{
      channel: channel,
      text: message
    }

    case request(:post, "/chat.postMessage", body) do
      {:ok, slack_response} -> {:ok, slack_response}
      _ -> :error
    end
  end

  ## HTTP helpers

  defp request(method, path, body) do
    url = host().slack_url() <> path
    headers = [{"authorization", "Bearer #{api_token()}"}]
    {headers, encoded_body} = encode_body(headers, body)
    request = Finch.build(method, url, headers, encoded_body)

    case Finch.request(request, FadBot.Finch) do
      {:ok, %{status: 200, body: body}} ->
        {:ok, Jason.decode!(body)}

      {:ok, %{status: status}} ->
        message = """
        Unexpected status #{status} from Slack:

            #{method} #{url}
            #{inspect(headers)}
        """

        Logger.error(message)
        {:error, RuntimeError.exception(message)}

      {:error, error} ->
        Logger.error("""
        Could not complete request to Slack:

            #{method} #{url}
            #{inspect(headers)}

        Reason: #{inspect(error)}
        """)

        {:error, error}
    end
  end

  defp encode_body(headers, body) when is_nil(body), do: {headers, body}

  defp encode_body(headers, body) do
    {[{"content-type", "application/x-www-form-urlencoded"} | headers], URI.encode_query(body)}
  end

  ## Keys and secrets

  defp host, do: Keyword.fetch!(slack_env(), :host)
  defp api_token, do: Keyword.fetch!(slack_env(), :api_token)
  defp slack_env, do: Application.fetch_env!(:fad_bot, :slack)
end
