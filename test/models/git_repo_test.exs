defmodule Stalker.GitRepoTest do
  use Stalker.ModelCase

  alias Stalker.GitRepo

  @valid_attrs %{name: "some content", path: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = GitRepo.changeset(%GitRepo{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = GitRepo.changeset(%GitRepo{}, @invalid_attrs)
    refute changeset.valid?
  end
end
