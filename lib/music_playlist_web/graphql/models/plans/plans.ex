defmodule MusicPlaylistWeb.Graphql.Models.Plans do
  use Absinthe.Schema.Notation
  alias MusicPlaylistWeb.Graphql.Resolvers
  alias MusicPlaylistWeb.Graphql.Middlewares
  import Absinthe.Resolution.Helpers, only: [dataloader: 1]

  object :plan_queries do
    @desc "Get all plans"
    field :plans, list_of(:plan_obj) do
      resolve &Resolvers.Plans.get_all_plans/3
    end

    @desc "Get plan by ID"
    field :plan, :plan_obj do
      arg :id, non_null(:id)
      resolve &Resolvers.Plans.get_plan/3
    end
  end

  object :plan_mutations do
    @desc "Create a new plan"
    field :create_plan, :plan_obj do
      arg :name, non_null(:string)
      arg :playlist_size, non_null(:integer)
      middleware Middlewares.Authenticate
      resolve &Resolvers.Plans.create_plan/3
    end

    @desc "Update a plan"
    field :update_plan, :plan_obj do
      arg :plan_id, non_null(:id)
      arg :name, :string
      arg :playlist_size, :integer
      middleware Middlewares.Authenticate
      resolve &Resolvers.Plans.update_plan/3
    end

    @desc "Delete a plan"
    field :delete_plan, :plan_obj do
      arg :plan_id, non_null(:id)
      middleware Middlewares.Authenticate
      resolve &Resolvers.Plans.delete_plan/3
    end
  end


  object :plan_obj do
    field :id, non_null(:id)
    field :name, non_null(:string)
    field :playlist_size, non_null(:integer)
    field :musics, list_of(:music_obj), resolve: dataloader(MusicPlaylist.Musics)
  end
end
