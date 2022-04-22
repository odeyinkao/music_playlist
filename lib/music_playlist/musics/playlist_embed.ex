defmodule MusicPlaylist.Musics.PlaylistEmbed do
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :musics, {:array, :map}
  end

  @doc false
  def changeset(playlist, attrs) do
    playlist
    |> cast(attrs, [:musics])
    |> validate_required([:musics])
  end
end
