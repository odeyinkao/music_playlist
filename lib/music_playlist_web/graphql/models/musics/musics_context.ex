defmodule MusicPlaylistWeb.Graphql.Models.MusicsContext do
  use Absinthe.Schema.Notation

  import_types(MusicPlaylistWeb.Graphql.Models.Musics)
  import_types(MusicPlaylistWeb.Graphql.Models.Playlists)

  object :music_context_queries do
    import_fields(:music_queries)
  end

  object :music_context_mutations do
    import_fields(:music_mutations)
    import_fields(:playlist_mutations)
  end
end
