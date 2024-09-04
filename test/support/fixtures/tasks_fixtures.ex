defmodule TaskManager.TasksFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `TaskManager.Tasks` context.
  """

  @doc """
  Generate a task.
  """
  def task_fixture(attrs \\ %{}) do
    {:ok, task} =
      attrs
      |> Enum.into(%{
        description: "some description",
        due_date: ~D[2024-09-15],
        status: "some status",
        title: "some title",
        user_id: "f8f91b6d-4739-413c-92ed-2f0abae25e7e"
      })
      |> TaskManager.Tasks.create_task()

    task
  end
end
