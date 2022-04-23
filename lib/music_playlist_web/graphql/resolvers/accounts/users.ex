defmodule MusicPlaylistWeb.Graphql.Resolvers.Users do
  alias MusicPlaylist.Accounts
  import MusicPlaylistWeb.Graphql.ChangesetErrors

  @doc """
  Resolver to update plan of current logged in user.

  Sign-in required.
  """
  def update_user_plan(_, %{plan_id: plan_id} = _args, %{context: %{current_user: current_user}}) do
    try do
      reset_playlist =
        current_user
        |> Map.get(:playlist)
        |> Map.replace!(:musics, [])
        |> Map.from_struct()

      case Accounts.update_user(current_user, %{plan_id: plan_id, playlist: reset_playlist}) do
        {:error, changeset} ->
          {:error, mapper(changeset)}
        {:ok, user} ->
          {:ok, user}
      end
    rescue
      Ecto.NoResultsError ->
        {:error, "Invalid plan ID given!"}
    end
  end
end
