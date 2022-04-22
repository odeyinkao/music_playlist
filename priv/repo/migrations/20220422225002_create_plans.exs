defmodule MusicPlaylist.Repo.Migrations.CreatePlans do
  use Ecto.Migration

  def change do
    create table(:plans) do
      add :name, :string
      add :playlist_size, :integer

      timestamps()
    end
  end
end
