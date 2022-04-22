defmodule MusicPlaylist.Repo do
  use Ecto.Repo,
    otp_app: :music_playlist,
    adapter: Ecto.Adapters.Postgres
end
