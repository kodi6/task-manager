defmodule TaskManager.TasksTest do
  use TaskManager.DataCase

  alias TaskManager.Tasks
  alias TaskManager.Accounts


  describe "tasks" do
    alias TaskManager.Tasks.Task

    alias TaskManager.Accounts.User

    import TaskManager.TasksFixtures
    import TaskManager.AccountsFixtures

    @invalid_attrs %{status: nil, description: nil, title: nil, due_date: nil, user_id: nil}

    test "create_task/1 with valid data creates a task" do

      user = user_fixture()

      valid_attrs = %{status: "some status", description: "some description", title: "some title", due_date: ~D[2024-09-15], user_id: user.id}

      assert {:ok, %Task{} = task} = Tasks.create_task(valid_attrs)
      assert task.status == "some status"
      assert task.description == "some description"
      assert task.title == "some title"
      assert task.due_date == ~D[2024-09-15]
    end

    test "get_user_tasks/1 returns all tasks with given user id" do
      user = user_fixture()
      task = task_fixture(%{user_id: user.id})
      IO.inspect(task, label: "task")
      assert Tasks.get_user_tasks(user.id) == [task]
    end
  end
end
