defmodule MusicPlaylist.MusicsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MusicPlaylist.Musics` context.
  """
  import MusicPlaylist.PlansFixtures

  @doc """
  Generate a music.
  """
  def music_fixture(attrs \\ %{}) do
    plan = plan_fixture()
    {:ok, music} =
      attrs
      |> Enum.into(%{
        name: "some name",
        plan_id: plan.id
      })
      |> MusicPlaylist.Musics.create_music()

    music
  end
end
