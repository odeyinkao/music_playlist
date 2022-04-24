defmodule MusicPlaylistWeb.Graphql.SetCurrentUser do
  @behaviour Plug

  import Plug.Conn
  alias MusicPlaylist.Accounts

  def init(opts), do: opts

  def call(conn, _) do
    context = build_context(conn)
    Absinthe.Plug.put_options(conn, context: %{current_user: context})
  end

  defp build_context(conn) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
        user <- Accounts.get_user_by_session_token(token) do
      AtomicMap.convert(user, safe: true)
    else
      _ -> nil
    end
  end
end
