defmodule MusicPlaylistWeb.Graphql.Schema do
  use Absinthe.Schema
  alias MusicPlaylist.{Plans, Musics, Accounts}
  alias MusicPlaylistWeb.Graphql.Dataloaders

  query do
    # All queries here
  end

  mutation do
    # All mutatations here
  end

  def context(ctx) do
    loader =
      Dataloader.new
      |> Dataloader.add_source(Accounts, Dataloaders.datasource())
      |> Dataloader.add_source(Plans, Dataloaders.datasource())
      |> Dataloader.add_source(Musics, Dataloaders.datasource())

    Map.put(ctx, :loader, loader)
  end

  def plugins do
    [Absinthe.Middleware.Dataloader] ++ Absinthe.Plugin.defaults()
  end
end
