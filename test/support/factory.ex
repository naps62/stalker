defmodule Stalker.Factory do
  use ExMachina.Ecto, repo: Stalker.Repo

  alias Stalker.GitRepo

  def factory(:git_repo, _attrs) do
    %GitRepo{
      name: "repo",
      path: "/repo"
    }
  end
end
