defmodule Stalker.StatsController do
  use Stalker.Web, :controller

  alias Stalker.GitAccess

  def git(conn, _params) do
    accesses = Repo.all(
      from a in Stalker.GitAccess,
      preload: [:git_repo]
    )

    render conn, "git.html", accesses: accesses
  end
end
