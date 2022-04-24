# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     MusicPlaylist.Repo.insert!(%MusicPlaylist.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.


alias MusicPlaylist.{Accounts, Plans, Musics}

{:ok, basic} =
  %{
    name: "Basic",
    playlist_size: 3
  } |> Plans.create_plan

{:ok, gold} =
  %{
    name: "Gold",
    playlist_size: 5
  } |> Plans.create_plan


%{
  email: "superuser@admin.com",
  password: "admin345",
  role: "superadmin",
  plan_id: 1,
} |> Accounts.register_user

[
  %{
    name: "Orient",
    plan_id: basic.id,
  },
  %{
    name: "Chiptune",
    plan_id: gold.id,
  },
  %{
    name: "EDM",
    plan_id: basic.id,
  },
  %{
    name: "Chillout",
    plan_id: gold.id,
  },
  %{
    name: "Dubstep",
    plan_id: gold.id,
  },
  %{
    name: "Winter",
    plan_id: basic.id,
  },
  %{
    name: "Summer",
    plan_id: basic.id,
  },
  %{
    name: "Ocarina",
    plan_id: gold.id,
  }
] |> Enum.each(&Musics.create_music(&1))
