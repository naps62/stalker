defmodule Stalker.GitRepoTest do
  use Stalker.ModelCase

  alias Stalker.GitRepo

  @valid_attrs %{name: "a-name", path: "/a-name"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = GitRepo.changeset(%GitRepo{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = GitRepo.changeset(%GitRepo{}, @invalid_attrs)
    refute changeset.valid?
  end

  test "get_or_insert_by with new params" do
    params = %{"name" => "a-name", "path" => "/a-name"}

    GitRepo.get_or_insert_by(params)

    assert Repo.one(from u in Stalker.GitRepo, select: count(u.id)) == 1
  end

  test "get_or_insert_by with existing params" do
    params = %{"name" => "a-name", "path" => "/a-name"}
    changeset = GitRepo.changeset(%GitRepo{}, params)
    existing = Repo.insert!(changeset)

    new = GitRepo.get_or_insert_by(params)

    assert new == existing
    assert Repo.one(from u in Stalker.GitRepo, select: count(u.id)) == 1
  end
end
