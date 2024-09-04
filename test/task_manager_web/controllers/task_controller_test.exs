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

  describe "create task" do
    test "renders task when data is valid", %{conn: conn} do
      user = user_fixture()

      create_attrs = %{
        status: "some status",
        description: "some description",
        title: "some title",
        due_date: ~D[2024-09-15],
        user_id: user.id
      }

      conn = post(conn, ~p"/api/users/#{user.id}/tasks", task: create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      user = user_fixture()

      conn = post(conn, ~p"/api/users/#{user.id}/tasks", task: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "show task" do
    test "renders task when task exists", %{conn: conn} do
      user = user_fixture()
      task = task_fixture(user_id: user.id)

      conn = get(conn, ~p"/api/users/#{user.id}/tasks/#{task.id}")

      response_data = json_response(conn, 200)["data"]

      assert response_data["id"] == task.id
      assert response_data["description"] == task.description
      assert response_data["due_date"] == Date.to_string(task.due_date)
      assert response_data["status"] == task.status
      assert response_data["title"] == task.title
      assert response_data["user_id"] == task.user_id
    end
  end

  describe "update task" do
    test "updates the task and renders the updated task when data is valid", %{conn: conn} do
      user = user_fixture()
      task = task_fixture(user_id: user.id)

      create_attrs = %{
        "title" => "updated title",
        "description" => "updated description",
        "due_date" => "2024-09-20",
        "status" => "updated status",
        user_id: user.id
      }

      conn = put(conn, ~p"/api/users/#{user.id}/tasks/#{task.id}", task: create_attrs)

      task_id = task.id
      user_id = user.id

      assert %{
               "id" => ^task_id,
               "description" => "updated description",
               "due_date" => "2024-09-20",
               "status" => "updated status",
               "title" => "updated title",
               "user_id" => ^user_id
             } = json_response(conn, 200)["data"]
    end

    test "returns errors when data is invalid", %{conn: conn} do
      user = user_fixture()
      task = task_fixture(user_id: user.id)

      conn = put(conn, ~p"/api/users/#{user.id}/tasks/#{task.id}", task: @invalid_attrs)
      assert %{"errors" => _errors} = json_response(conn, 422)
    end
  end

  test "deletes task", %{conn: conn} do
    user = user_fixture()
    task = task_fixture(user_id: user.id)

    conn = delete(conn, ~p"/api/users/#{user.id}/tasks/#{task.id}")

    assert response(conn, 204)

    conn = get(conn, ~p"/api/users/#{user.id}/tasks/#{task.id}")

    assert response(conn, 404)
  end
end
