defmodule MusicPlaylistWeb.Graphql.Schema do
  use Absinthe.Schema
  alias MusicPlaylist.{Plans, Musics, Accounts}
  alias MusicPlaylistWeb.Graphql.Dataloaders

  import_types(MusicPlaylistWeb.Graphql.Models.Plans)
  import_types(MusicPlaylistWeb.Graphql.Models.MusicsContext)
  import_types(MusicPlaylistWeb.Graphql.Models.Accounts)

  query do
    import_fields(:plan_queries)
    import_fields(:music_context_queries)
    import_fields(:account_queries)
  end

  mutation do
    import_fields(:plan_mutations)
    import_fields(:music_context_mutations)
    import_fields(:account_mutations)
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
