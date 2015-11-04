defmodule Stalker.PageControllerTest do
  use Stalker.ConnCase, async: false

  test "POST /api/git/enter" do
    conn = post conn(), "/api/git/enter", %{path: "/name", pid: "1", timestamp: 0}
    assert response(conn, 200)

    assert Repo.one(from u in Stalker.GitRepo, select: count(u.id)) == 1
    assert Repo.one(from u in Stalker.GitAccess, select: count(u.id)) == 1
  end

  test "POST /api/git/exit with no prior entry" do
    post conn(), "/api/git/exit", %{path: "/name", pid: "1", timestamp: 0}

    assert Repo.one(from u in Stalker.GitRepo, select: count(u.id)) == 0
  end

  test "enterthen exit" do
    post conn(), "/api/git/enter", %{path: "/name", pid: "1", timestamp: 0}
    post conn(), "/api/git/exit", %{path: "/name", pid: "1", timestamp: 10}

    assert Repo.one(from u in Stalker.GitRepo, select: count(u.id)) == 1
    assert Repo.one(from u in Stalker.GitAccess, select: count(u.id)) == 1
  end
end
