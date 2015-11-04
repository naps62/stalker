defmodule Stalker.GitRepo do
  use Stalker.Web, :model
  schema "git_repos" do
    field :path, :string
    field :name, :string

    has_many :git_repo_accesses, GitAccess

    timestamps
  end

  before_insert :set_name

  @required_fields ~w(path)
  @optional_fields ~w(name)


  @doc """
  Creates a changeset based on the `model` and `params`.

  If no params are provided, an invalid changeset is returned
  with no validation performed.
  """
  def changeset(model, params \\ :empty) do
    model
    |> cast(params, @required_fields, @optional_fields)
  end

  def set_name(changeset) do
    name = changeset
      |> Ecto.Changeset.get_field(:path)
      |> String.split("/")
      |> List.last

    changeset |> change(%{name: name})
  end
end
