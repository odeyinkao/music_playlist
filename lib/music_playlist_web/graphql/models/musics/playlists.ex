defmodule MusicPlaylistWeb.Graphql.Models.Playlists do
  use Absinthe.Schema.Notation
  alias MusicPlaylistWeb.Graphql.Resolvers
  alias MusicPlaylistWeb.Graphql.Middlewares

  object :playlist_mutations do
    @desc "Update a user's playlist"
    field :update_user_playlist, :user_obj do
      arg :music_ids, list_of(:id)
      middleware Middlewares.Authenticate
      resolve &Resolvers.Playlists.update_user_playlist/3
    end
  end

  object :playlist_obj do
    field :musics, list_of(:playlist_music_obj)
  end

  object :playlist_music_obj do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :plan, non_null(:playlist_plan_obj)
  end

  object :playlist_plan_obj do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :playlist_size, non_null(:integer)
  end

  input_object :playlist_input_obj do
    field :name, :string
    field :musics, list_of(:id)
  end
end
