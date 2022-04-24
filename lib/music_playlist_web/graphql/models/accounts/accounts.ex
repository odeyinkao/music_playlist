defmodule MusicPlaylistWeb.Graphql.Models.Accounts do
  use Absinthe.Schema.Notation

  import_types(MusicPlaylistWeb.Graphql.Models.UserTokens)
  import_types(MusicPlaylistWeb.Graphql.Models.Users)

  object :account_queries do
    import_fields(:user_token_queries)
    import_fields(:user_queries)
  end

  object :account_mutations do
    import_fields(:user_token_mutations)
    import_fields(:user_mutations)
  end
end
