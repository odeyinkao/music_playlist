defmodule MusicPlaylistWeb.Graphql.Models.UserTokens do
  use Absinthe.Schema.Notation
  alias MusicPlaylistWeb.Graphql.Middlewares
  alias MusicPlaylistWeb.Resolvers

  object :user_token_queries do
    @desc "Get the currently signed-in user"
    field :me, :user_obj do
      middleware Middlewares.Authenticate
      resolve(&Resolvers.UserTokens.me/3)
    end
  end

  object :user_token_mutations do
    @desc "Create a user account"
    field :signup, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.UserTokens.signup/3)
    end

    @desc "Sign in a user"
    field :signin, :session do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&Resolvers.UserTokens.signin/3)
    end

    @desc "Sign out a user"
    field :signout, :user_obj do
      arg(:token, non_null(:string))
      resolve(&Resolvers.UserTokens.signout/3)
    end
  end

  object :session do
    field :user, non_null(:user_obj)
    field :token, non_null(:string)
  end

end
