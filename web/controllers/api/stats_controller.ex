defmodule Stalker.API.StatsController do
  use Stalker.Web, :controller

  alias Stalker.GitAccess

  def git_repos(conn, _params) do
    accesses = Repo.all(Stalker.GitAccess)
    json conn, accesses
  end
end
