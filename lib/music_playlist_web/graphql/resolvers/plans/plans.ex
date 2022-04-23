defmodule MusicPlaylistWeb.Graphql.Resolvers.Plans do
  alias MusicPlaylist.Plans
  import MusicPlaylistWeb.Graphql.ChangesetErrors

  @doc """
  Resolver to create a plan.

  Sign-in required.
  """
  def create_plan(_, arg, %{context: %{current_user: _current_user}}) do
    case Plans.create_plan(arg) do
      {:error, changeset} ->
        {:error, mapper(changeset)}
      {:ok, plan} ->
        {:ok, plan}
    end
  end

  @doc """
  Resolver to update a plan.

  Sign-in required.
  """
  def update_plan(_, %{plan_id: plan_id} = args, %{context: %{current_user: _current_user}}) do
    try do
      case String.to_integer(plan_id) |> Plans.get_plan! |> Plans.update_plan(args) do
        {:error, changeset} ->
          {:error, mapper(changeset)}
        {:ok, plan} ->
          {:ok, plan}
      end
    rescue
      Ecto.NoResultsError ->
        {:error, "No plan found!"}
    end
  end

  @doc """
  Resolver to delete a plan.

  Sign-in required.
  """
  def delete_plan(_, %{plan_id: plan_id} = _args, %{context: %{current_user: _current_user}}) do
    try do
      case String.to_integer(plan_id) |> Plans.get_plan!() |> Plans.delete_plan() do
        {:error, changeset} ->
          {:error, mapper(changeset)}
        {:ok, deleted_plan} ->
          {:ok, deleted_plan}
      end
    rescue
      Ecto.NoResultsError ->
        {:error, "No plan found!"}
    end
  end

  def get_all_plans(_, _, _) do
    {:ok, Plans.list_plans()}
  end

  def get_plan(_, %{id: id}, _) do
    try do
      {:ok, Plans.get_plan!(id)}
    rescue
      Ecto.NoResultsError ->
        {:error, "No plan found!"}
    end
  end

end
