defmodule TaskManager.Tasks do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias TaskManager.Repo

  alias TaskManager.Tasks.Task


  @doc """
    Creates a task.
  """

  def create_task(attrs \\ %{}) do
    %Task{}
    |> Task.changeset(attrs)
    |> Repo.insert()
  end


  @doc """
  Retrieves all tasks for the specified user.
  """
  def get_user_tasks(user_id) do
    Task
    |> where([t], t.user_id == ^user_id)
    |> Repo.all()
  end

end
