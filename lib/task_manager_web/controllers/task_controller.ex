defmodule TaskManagerWeb.TaskController do
  use TaskManagerWeb, :controller

  alias TaskManager.Tasks
  alias TaskManager.Tasks.Task

  action_fallback TaskManagerWeb.FallbackController

  def index(conn, %{"user_id" => user_id}) do
    tasks = Tasks.get_user_tasks(user_id)

    case tasks do
      [] ->
        {:error, :not_found}

      tasks ->
        render(conn, :index, tasks: tasks)
    end
  end

  def create(conn, %{"task" => task_params}) do
    with {:ok, %Task{} = task} <- Tasks.create_task(task_params) do
      conn
      |> put_status(:created)
      |> render(:show, task: task)
    end
  end

  def show(conn, %{"user_id" => user_id, "task_id" => task_id}) do
    case Tasks.get_user_task(user_id, task_id) do
      nil ->
        {:error, :not_found}

      task ->
        render(conn, :show, task: task)
    end
  end

  def update(conn, %{"user_id" => user_id, "task_id" => task_id, "task" => task_params}) do
    with {:ok, %Task{} = task} <- Tasks.update_user_task(user_id, task_id, task_params) do
      render(conn, :show, task: task)
    end
  end

  def delete(conn, %{"user_id" => user_id, "task_id" => task_id}) do
    with {:ok, %Task{}} <- Tasks.delete_user_task(user_id, task_id) do
      send_resp(conn, :no_content, "")
    end
  end
end
