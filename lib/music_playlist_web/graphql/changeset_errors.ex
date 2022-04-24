defmodule MusicPlaylistWeb.Graphql.ChangesetErrors do
  @doc """
  Traverse he changeset errors and returns a map of error
  messages. For example:

  %{start_date: ["can't be blank"], end_date: ["can't be blank"]}
  """
  def mapper(%Ecto.Changeset{} = changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(String.capitalize(acc), "%{#{key}}", _to_string(value))
      end)
    end)
    |> Enum.reduce(
        "",
        fn {k, v}, acc ->
          joined_errors = Enum.join(v, "\n; ")
          "#{acc} " <> String.capitalize(Atom.to_string(k))<> ": #{joined_errors}"
        end
        )
  end
  def mapper(changeset), do: changeset

  defp _to_string(val) when is_list(val) do
    Enum.join(val, ",")
  end
  defp _to_string(val), do: to_string(val)
end
