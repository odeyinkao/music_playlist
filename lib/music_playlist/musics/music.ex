defmodule MusicPlaylist.Musics.Music do
  use Ecto.Schema
  import Ecto.Changeset

  schema "musics" do
    field :name, :string
    belongs_to :plan, MusicPlaylist.Plans.Plan, foreign_key: :plan_id

    timestamps()
  end

  @doc false
  def changeset(music, attrs) do
    music
    |> cast(attrs, [:name, :plan_id])
    |> validate_required([:name, :plan_id])
    |> foreign_key_constraint(:plan, name: :musics_plan_id_fkey, message: "the plan ID does not exist")
  end
end
