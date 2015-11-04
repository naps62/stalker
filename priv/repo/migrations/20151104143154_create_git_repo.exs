defmodule Stalker.Repo.Migrations.CreateGitRepo do
  use Ecto.Migration

  def change do
    create table(:git_repos) do
      add :name, :string
      add :path, :string

      timestamps
    end

  end
end
