defmodule MusicPlaylist.PlansFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `MusicPlaylist.Plans` context.
  """

  @doc """
  Generate a plan.
  """
  def plan_fixture(attrs \\ %{}) do
    {:ok, plan} =
      attrs
      |> Enum.into(%{
        name: "some name",
        playlist_size: 42
      })
      |> MusicPlaylist.Plans.create_plan()

    plan
  end
end
