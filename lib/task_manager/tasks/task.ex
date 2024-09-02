defmodule TaskManager.Tasks.Task do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "tasks" do
    field :status, :string
    field :description, :string
    field :title, :string
    field :due_date, :date
    field :user_id, :binary_id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(task, attrs) do
    task
    |> cast(attrs, [:title, :description, :due_date, :status])
    |> validate_required([:title, :description, :due_date, :status])
  end
end
