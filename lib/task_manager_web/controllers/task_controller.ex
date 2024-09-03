defmodule TaskManagerWeb.TaskController do
  use TaskManagerWeb, :controller

  alias TaskManager.Tasks
  alias TaskManager.Tasks.Task

  action_fallback TaskManagerWeb.FallbackController


  def index(conn, %{"user_id" => user_id}) do
    tasks = Tasks.get_user_tasks(user_id)
    render(conn, :index, tasks: tasks)
  end


  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> render(:show, task: task)
    end
  end
end
