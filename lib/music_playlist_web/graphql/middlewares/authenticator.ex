defmodule MusicPlaylistWeb.Graphql.Middlewares.Authenticate do
  @behaviour Absinthe.Middleware

  def call(resolution, _opts) do
    case resolution.context do
      %{current_user: nil} ->
        Absinthe.Resolution.put_result(resolution, {:error, "Sign-in required!"})
      %{current_user: _current_user} ->
        resolution
    end
  end
end
