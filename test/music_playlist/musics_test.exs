defmodule MusicPlaylist.MusicsTest do
  use MusicPlaylist.DataCase

  alias MusicPlaylist.Musics

  describe "musics" do
    alias MusicPlaylist.Musics.Music

    import MusicPlaylist.{MusicsFixtures, PlansFixtures}

    @invalid_attrs %{name: nil}

    test "list_musics/0 returns all musics" do
      music = music_fixture()
      assert Musics.list_musics() == [music]
    end

    test "get_music!/1 returns the music with given id" do
      music = music_fixture()
      assert Musics.get_music!(music.id) == music
    end

    test "create_music/1 with valid data creates a music" do
      plan = plan_fixture()
      valid_attrs = %{name: "some name", plan_id: plan.id}

      assert {:ok, %Music{} = music} = Musics.create_music(valid_attrs)
      assert music.name == "some name"
    end

    test "create_music/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Musics.create_music(@invalid_attrs)
    end

    test "update_music/2 with valid data updates the music" do
      music = music_fixture()
      update_attrs = %{name: "some updated name"}

      assert {:ok, %Music{} = music} = Musics.update_music(music, update_attrs)
      assert music.name == "some updated name"
    end

    test "update_music/2 with invalid data returns error changeset" do
      music = music_fixture()
      assert {:error, %Ecto.Changeset{}} = Musics.update_music(music, @invalid_attrs)
      assert music == Musics.get_music!(music.id)
    end

    test "delete_music/1 deletes the music" do
      music = music_fixture()
      assert {:ok, %Music{}} = Musics.delete_music(music)
      assert_raise Ecto.NoResultsError, fn -> Musics.get_music!(music.id) end
    end

    test "change_music/1 returns a music changeset" do
      music = music_fixture()
      assert %Ecto.Changeset{} = Musics.change_music(music)
    end
  end
end
