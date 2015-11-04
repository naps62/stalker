defmodule Stalker.API.GitEventsController do
  use Stalker.Web, :controller

  alias Stalker.GitRepo
  alias Stalker.GitAccess

  def enter(conn, params) do
    repo = git_repo(params)


    access_params = %{
      git_repo_id: repo.id,
      pid: Map.get(params, "pid"),
      entered_at: Map.get(params, "timestamp") |> date_from_timestamp
    }

    changeset = GitAccess.changeset(%GitAccess{}, access_params)
    Repo.insert!(changeset)

    conn
    |> send_resp(200, "")
  end

  def exit(conn, _params) do
    conn
    |> send_resp(200, "")
  end

  defp git_repo(params) do
    case Repo.get_by(GitRepo, path: Map.get(params, "path")) do
      nil ->
        changeset = GitRepo.changeset(%GitRepo{}, params)
        Repo.insert!(changeset)
        repo -> repo
    end
  end

  defp date_from_timestamp(timestamp) do
    case (Stalker.TimestampConvert.from_timestamp(timestamp) |> Ecto.DateTime.cast) do
      {:ok, date} -> date
      _ -> nil
    end
  end
end
