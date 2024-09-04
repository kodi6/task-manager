defmodule TaskManagerWeb.TaskControllerTest do
  use TaskManagerWeb.ConnCase

  import TaskManager.TasksFixtures
  import TaskManager.AccountsFixtures


  alias TaskManager.Tasks.Task


  @update_attrs %{
    status: "some updated status",
    description: "some updated description",
    title: "some updated title",
    due_date: ~D[2024-09-16],
    user_id: "f8f91b6d-4739-413c-92ed-2f0abae25e7a"
  }

  @invalid_attrs %{status: nil, description: nil, title: nil, due_date: nil, user_id: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tasks", %{conn: conn} do
      user = user_fixture()
      task = task_fixture(user_id: user.id)

      conn = get(conn, ~p"/api/users/#{user.id}/tasks")

      response_data = json_response(conn, 200)["data"]
      [task_data] = response_data
      assert task_data["id"] == task.id
      assert task_data["title"] == task.title
      assert task_data["status"] == task.status
      assert task_data["description"] == task.description
      assert task_data["due_date"] == Date.to_string(task.due_date)
      assert task_data["user_id"] == task.user_id
    end
  end

end
