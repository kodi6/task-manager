defmodule TaskManagerWeb.TaskJSON do
  alias TaskManager.Tasks.Task


  @doc """
  Renders a single task.
  """
  def show(%{task: task}) do
    %{data: data(task)}
  end

  defp data(%Task{} = task) do
    %{
      id: task.id,
      title: task.title,
      description: task.description,
      status: task.status,
      due_date: task.due_date,
      user_id: task.user_id
    }
  end
end
