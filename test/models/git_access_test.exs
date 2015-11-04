defmodule Stalker.GitAccessTest do
  use Stalker.ModelCase

  alias Stalker.GitAccess

  @valid_attrs %{entered_at: "2010-04-17 14:00:00", exited_at: "2010-04-17 14:00:00", pid: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = GitAccess.changeset(%GitAccess{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = GitAccess.changeset(%GitAccess{}, @invalid_attrs)
    refute changeset.valid?
  end
end
