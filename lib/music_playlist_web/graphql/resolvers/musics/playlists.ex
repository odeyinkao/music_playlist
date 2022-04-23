defmodule MusicPlaylistWeb.Graphql.Resolvers.Playlists do

  @doc """
  Resolver to update playlist of current logged in user.

  Sign-in required.
  """
  def update_user_playlist(_, %{music_ids: music_ids} = _args, %{context: %{current_user: current_user}}) when length(music_ids) < 1 do
    updated_playlist =
      current_user
      |> Map.get(:playlist)
      |> Map.from_struct()
      |> Map.replace!(:musics, [])

    case MusicPlaylist.Accounts.update_user(current_user, %{playlist: updated_playlist}) do
      {:error, _changeset} ->
        {:error, "Could not update user!"}
      {:ok, user} ->
        {:ok, user}
    end
  end

  def update_user_playlist(_, %{music_ids: music_ids} = _args, %{context: %{current_user: current_user}}) do
    music_ids =
      music_ids
      |> Enum.uniq_by(fn x -> x end)

    with :ok <- check_user_has_plan(current_user),
      :ok <- check_user_plan(music_ids, current_user),
      [_|_] = musics <- check_music_list(music_ids),
      :ok <- can_user_add_music(musics, current_user) do

      musics =
        musics
        |> Enum.map(
            fn music ->
              music
              |> Map.drop([:__meta__, :__struct__])
              |> Map.update!(
                :plan,
                fn plan ->
                  plan |> Map.drop([:__struct__, :__meta__, :musics, :users, :inserted_at, :updated_at])
                end
              )
            end
          )

      updated_playlist =
        current_user
        |> Map.get(:playlist)
        |> Map.from_struct()
        |> Map.replace!(:musics, musics)

      case MusicPlaylist.Accounts.update_user(current_user, %{playlist: updated_playlist}) do
        {:error, _changeset} ->
          {:error, "Could not update user!"}
        {:ok, user} ->
          {:ok, user}
      end
    end
  end

  @doc """
  Check the list of music IDs if they are all valid and exists.

  ## Parameters
    - music_list: A list of music IDs.

  ## Examples

      iex> check_music_list([12, 32])
      [%Music{}, ...]

      iex> check_music_list([21, 23])
      {:error, "You have an invalid ID in the list given."}

  """
  defp check_music_list(music_list) do
    try do
      Enum.map(music_list, fn music_id -> MusicPlaylist.Musics.get_music_with_plan(music_id) end )
    rescue
      _ ->
        {:error, "You have an invalid ID in the list given."}
    end
  end

  @doc """
  Check if user has subscribed to a plan.

  ## Parameters
    - user: A user struct.

  ## Examples

      iex> check_user_has_plan(user)
      :ok

      iex> check_user_has_plan(user)
      {:error, "You do not have any plan currently. Please subscribe for a plan before adding your music."}

  """
  defp check_user_has_plan(user) do
    if user.plan_id !== nil, do: :ok, else: {:error, "You do not have any plan currently. Please subscribe for a plan before adding your music."}
  end

  @doc """
  Check if user has exceeded the number of music the user's plan
  allows him to add to his playlist.

  ## Parameters
    - music_ids: A list of music IDs.
    - user: A user struct.

  ## Examples

      iex> check_user_plan(music_ids, user)
      :ok

      iex> check_user_plan(music_ids, user)
      {:error, "You have reached your playlist limit. You are allowed to add only PlanPlaysize music the PlanName plan. Upgrade to add more!"}

  """
  defp check_user_plan(music_ids, user) do
    user_plan = MusicPlaylist.Plans.get_plan!(user.plan_id)
    if length(music_ids) <= user_plan.playlist_size, do: :ok, else: {:error, "You have reached your playlist limit. You are allowed to add only #{user_plan.playlist_size} music the #{user_plan.name} plan. Upgrade to add more!"}
  end

  @doc """
  Check if a user's plan allows him to add
  all the given musics to his playlist.

  ## Parameters
    - musics: A list of music structs.
    - user: A user struct.

  ## Examples

      iex> can_user_add_music(musics, user)
      :ok

      iex> can_user_add_music(musics, user)
      {:error, "You cannot add music of higher plans. Upgrade your plan to add more music."}

  """
  defp can_user_add_music(musics, user) do
    music_plans =
      Enum.map(musics, fn music -> music.plan_id end)
      |> Enum.uniq_by(fn x -> x end)

    if user.plan_id == 1 && Enum.any?(music_plans, fn plan_id -> plan_id > 1 end), do: {:error, "You cannot add music of higher plans. Upgrade your plan to add more music."}, else: :ok
  end
end
