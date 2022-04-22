defmodule MusicPlaylist.MusicsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MusicPlaylist.Musics` context.
  """

  @doc """
  Generate a music.
  """
  def music_fixture(attrs \\ %{}) do
    {:ok, music} =
      attrs
      |> Enum.into(%{
        name: "some name"
      })
      |> MusicPlaylist.Musics.create_music()

    music
  end
end
