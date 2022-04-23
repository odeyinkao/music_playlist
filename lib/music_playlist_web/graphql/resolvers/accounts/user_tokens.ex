defmodule MusicPlaylistWeb.Resolvers.UserTokens do
  alias MusicPlaylist.Accounts
  import MusicPlaylistWeb.Graphql.ChangesetErrors

  @doc """
  Resolver for users sign in.
  """
  def signin(_, %{email: email, password: password}, _) do
    case Accounts.get_user_by_email_and_password(email, password) do
      nil ->
        {:error, "Whoops, invalid credentials!"}

      user ->
        token = Accounts.generate_user_session_token(user)
        response = %{user: user, token: token}

        {:ok, AtomicMap.convert(response, safe: true)}
    end
  end

  @doc """
  Resolver for users sign up.
  """
  def signup(_, args, _) do
    case Accounts.register_user(Map.put(args, :plan_id, 1)) do
      {:error, changeset} ->
        {:error, mapper(changeset)}
      {:ok, user} ->
        playlist_name =
          String.split(user.email, "@")
          |> List.first()

        {:ok, user} = Accounts.update_user(
          user, %{playlist: %{name: playlist_name, musics: []}}
        )
        token = Accounts.generate_user_session_token(user)
        response = %{user: user, token: token}
        {:ok, AtomicMap.convert(response, safe: true)}
    end
  end

  @doc """
  Resolver to get record of current logged in user.

  Sign-in required.
  """
  def me(_, _, %{context: %{current_user: user}}) do
    {:ok, user}
  end

  def me(_, _, _) do
    {:ok, nil}
  end

  @doc """
  Resolver to sign-out user.
  """
  def signout(_, %{token: token}, %{context: %{current_user: user}}) do
    try do
      Accounts.delete_session_token(token)
      {:ok, user}
    rescue
      _ ->
        {:error, "Unable to sign out."}
    end
  end

end
