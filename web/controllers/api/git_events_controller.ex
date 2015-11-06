defmodule Stalker.API.GitEventsController do
  use Stalker.Web, :controller

  alias Stalker.GitRepo
  alias Stalker.GitAccess

  def enter(conn, params) do
    repo = GitRepo.get_or_insert_by(params)

    changeset = GitAccess.changeset(%GitAccess{}, git_access_enter_params(repo, params))

    case Repo.insert(changeset) do
      {:ok, _}    -> send_resp(conn, 200, "")
      {:error, _} -> send_resp(conn, 422, "")
    end
  end

  def exit(conn, %{"path" => path, "pid" => pid} = params) do
    case Repo.get_by(GitRepo, path: path) do
      nil -> send_resp(conn, 422, "")
      repo ->
        access = Repo.update_all(
          from(access in GitAccess,
            where: access.pid == ^pid,
            where: access.git_repo_id == ^repo.id,
            where: is_nil(access.exited_at)),
          set: [exited_at: git_access_exit_params(params).exited_at]
        )
        send_resp(conn, 200, "")
    end
  end

  defp git_access_enter_params(git_repo, %{"pid" => pid, "timestamp" => timestamp}) do
    %{
      git_repo_id: git_repo.id,
      pid: pid,
      entered_at: date_from_timestamp(timestamp)
    }
  end

  defp git_access_exit_params(%{"timestamp" => timestamp}) do
    %{exited_at: date_from_timestamp(timestamp)}
  end

  defp date_from_timestamp(nil), do: nil
  defp date_from_timestamp(timestamp) do
    timestamp
    |> Stalker.TimestampConvert.from_timestamp
    |> Ecto.DateTime.cast
end
