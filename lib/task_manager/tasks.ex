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

  @doc """
  Retrieves a specific task for the specified user.
  """
  def get_user_task(user_id, task_id) do
    Task
    |> where([t], t.user_id == ^user_id and t.id == ^task_id)
    |> Repo.one()
  end

  @doc """
  Updates a specific task for the specified user.
  """
  def update_user_task(user_id, task_id, attrs) do
    Task
    |> where([t], t.user_id == ^user_id and t.id == ^task_id)
    |> Repo.one()
    |> case do
      nil -> {:error, :not_found}
      task -> task |> Task.changeset(attrs) |> Repo.update()
    end
  end

end
