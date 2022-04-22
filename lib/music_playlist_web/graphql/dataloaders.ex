defmodule MusicPlaylistWeb.Graphql.Dataloaders do
  alias MusicPlaylist.Repo

  def datasource() do
    Dataloader.Ecto.new(Repo, query: &query/2)
  end

  def query(queryable, _) do
    queryable
  end
end
