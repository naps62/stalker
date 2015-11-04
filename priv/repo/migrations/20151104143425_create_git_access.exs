defmodule Stalker.Repo.Migrations.CreateGitAccess do
  use Ecto.Migration

  def change do
    create table(:git_access) do
      add :pid, :string
      add :entered_at, :datetime
      add :exited_at, :datetime
      add :git_repo_id, references(:git_repos)

      timestamps
    end
    create index(:git_access, [:git_repo_id])

  end
end
