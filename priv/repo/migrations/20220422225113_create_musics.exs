defmodule MusicPlaylist.Repo.Migrations.CreateMusics do
  use Ecto.Migration

  def change do
    create table(:musics) do
      add :name, :string
      add :plan_id, references(:plans, on_delete: :nothing)

      timestamps()
    end

    create index(:musics, [:plan_id])
  end
end
