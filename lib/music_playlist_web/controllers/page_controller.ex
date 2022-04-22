defmodule MusicPlaylistWeb.PageController do
  use MusicPlaylistWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
