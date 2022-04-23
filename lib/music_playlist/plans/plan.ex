defmodule MusicPlaylist.Plans.Plan do
  use Ecto.Schema
  import Ecto.Changeset

  schema "plans" do
    field :name, :string
    field :playlist_size, :integer

    has_many :musics, MusicPlaylist.Musics.Music
    has_many :users, MusicPlaylist.Accounts.User
    timestamps()
  end

  @doc false
  def changeset(plan, attrs) do
    plan
    |> cast(attrs, [:name, :playlist_size])
    |> validate_required([:name, :playlist_size])
  end

  def delete_changeset(plan) do
    plan
    |> cast(%{}, [])
    |> foreign_key_constraint(:musics, name: :musics_plan_id_fkey, message: "some musics are attached to this plan")
    |> foreign_key_constraint(:users, name: :users_plan_id_fkey, message: "some users are subscribed to this plan")
  end
end
