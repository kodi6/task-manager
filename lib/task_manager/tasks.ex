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
end
