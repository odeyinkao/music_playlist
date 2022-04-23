defmodule MusicPlaylistWeb.Graphql.Resolvers.Musics do
  alias MusicPlaylist.Musics
  import MusicPlaylistWeb.Graphql.ChangesetErrors

  @doc """
  Resolver to create new music.

  Sign-in required.
  """
  def create_music(_, arg, %{context: %{current_user: _current_user}}) do
    case Musics.create_music(arg) do
      {:error, changeset} ->
        {:error, mapper(changeset)}
      {:ok, music} ->
        {:ok, music}
    end
  end

  @doc """
  Resolver to update a music.

  Sign-in required.
  """
  def update_music(_, %{music_id: music_id} = args, %{context: %{current_user: _current_user}}) do
    try do
      case String.to_integer(music_id) |> Musics.get_music!() |> Musics.update_music(args) do
        {:error, changeset} ->
          {:error, mapper(changeset)}
        {:ok, music} ->
          {:ok, music}
      end
    rescue
      Ecto.NoResultsError ->
        {:error, "No music found!"}
    end
  end

  @doc """
  Resolver to delete a music.

  Sign-in required.
  """
  def delete_music(_, %{music_id: music_id} = _args, %{context: %{current_user: _current_user}}) do
    try do
      case String.to_integer(music_id) |> Musics.get_music!() |> Musics.delete_music() do
        {:error, _changeset} ->
          {:error, "Could not delete music!"}
        {:ok, deleted_music} ->
          {:ok, deleted_music}
      end
    rescue
      Ecto.NoResultsError ->
        {:error, "No music found!"}
    end
  end

  @doc """
  Resolver to get all music.
  """
  def get_all_musics(_, _, _) do
    {:ok, Musics.list_musics()}
  end

  @doc """
  Resolver to get a single music.
  """
  def get_music(_, %{id: id}, _) do
    try do
      {:ok, Musics.get_music!(id)}
    rescue
      Ecto.NoResultsError ->
        {:error, "No music found!"}
    end
  end

end
