defmodule Stalker.PageControllerTest do
  use Stalker.ConnCase, async: false

  @params %{"path" => "/name", "pid" => "1", "timestamp" => 0}

  test "POST /api/git/enter" do
    conn = post conn(), "/api/git/enter", @params

    assert response(conn, 200)
    assert Repo.one(from u in Stalker.GitRepo, select: count(u.id)) == 1
    assert Repo.one(from u in Stalker.GitAccess, select: count(u.id)) == 1
  end

  test "POST /api/git/exit with no prior entry" do
    conn = post conn(), "/api/git/exit", @params

    assert response(conn, 422)
    assert Repo.one(from u in Stalker.GitRepo, select: count(u.id)) == 0
  end

  test "enter then exit" do
    post conn(), "/api/git/enter", @params
    conn = post conn(), "/api/git/exit", @params

    assert response(conn, 200)
    assert Repo.one(from u in Stalker.GitRepo, select: count(u.id)) == 1
    assert Repo.one(from u in Stalker.GitAccess, select: count(u.id)) == 1
  end
end
