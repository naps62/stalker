defmodule Stalker.GitAccess do
  use Stalker.Web, :model

  schema "git_access" do
    field :pid, :string
    field :entered_at, Ecto.DateTime
    field :exited_at, Ecto.DateTime
    belongs_to :git_repo, Stalker.GitRepo

    timestamps
  end

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

  def duration(model) do
    use Timex

    entered = Ecto.DateTime.to_erl(model.entered_at)
    exited = case model.exited_at do
      nil -> :calendar.local_time()
      datetime -> Ecto.DateTime.to_erl(datetime)
    end

    Date.diff(Date.from(entered), Date.from(exited), :timestamp)
    |> Ecto.Date.from_erl
  end
end
