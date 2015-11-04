defmodule Stalker.GitAccess do
  use Stalker.Web, :model

  schema "git_access" do
    field :pid, :string
    field :entered_at, Ecto.DateTime
    field :exited_at, Ecto.DateTime
    belongs_to :git_repo, Stalker.GitRepo

    timestamps
  end

  # before_insert :set_entered_at

  @required_fields ~w(pid git_repo_id entered_at)
  @optional_fields ~w(exited_at)

  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  # def set_entered_at(changeset) do
  #   case fetch_field(changeset, :timestamp) do
  #     {:changes, nil}
  #   end
  # end
end
