defmodule MusicPlaylistWeb.Graphql.Models.Users do
  use Absinthe.Schema.Notation
  alias MusicPlaylistWeb.Graphql.Resolvers
  alias MusicPlaylistWeb.Graphql.Middlewares
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :user_queries do
  end

  object :user_mutations do
    @desc "Update user plan"
    field :me, :user_obj do
      arg :plan_id, :integer
      middleware Middlewares.Authenticate
      resolve &Resolvers.Users.update_user_plan/3
    end
  end

  object :user_obj do
    field :id, non_null(:id)
    field :email, non_null(:string)
    field :plan, non_null(:plan_obj), resolve: dataloader(MusicPlaylist.Plans)
    field :role, non_null(:string)
    field :playlist, :playlist_obj
  end

end
