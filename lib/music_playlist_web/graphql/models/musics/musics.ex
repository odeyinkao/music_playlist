defmodule MusicPlaylistWeb.Graphql.Models.Musics do
  use Absinthe.Schema.Notation
  alias MusicPlaylistWeb.Graphql.Resolvers
  alias MusicPlaylistWeb.Graphql.Middlewares
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :music_queries do
    @desc "Get all musics"
    field :musics, list_of(:music_obj) do
      resolve &Resolvers.Musics.get_all_musics/3
    end

    @desc "Get music by ID"
    field :music, :music_obj do
      arg :id, non_null(:id)
      resolve &Resolvers.Musics.get_music/3
    end
  end

  object :music_mutations do
    @desc "Create a new music"
    field :create_music, :music_obj do
      arg :name, non_null(:string)
      arg :plan_id, non_null(:integer)
      middleware Middlewares.Authenticate
      resolve &Resolvers.Musics.create_music/3
    end

    @desc "Update a music"
    field :update_music, :music_obj do
      arg :music_id, non_null(:id)
      arg :name, :string
      arg :plan_id, :integer
      middleware Middlewares.Authenticate
      resolve &Resolvers.Musics.update_music/3
    end

    @desc "Delete a music"
    field :delete_music, :music_obj do
      arg :music_id, non_null(:id)
      middleware Middlewares.Authenticate
      resolve &Resolvers.Musics.delete_music/3
    end
  end

  object :music_obj do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :plan, non_null(:plan_obj), resolve: dataloader(MusicPlaylist.Plans)
  end
end
