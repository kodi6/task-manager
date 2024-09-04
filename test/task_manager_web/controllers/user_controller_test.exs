defmodule TaskManagerWeb.UserControllerTest do
  use TaskManagerWeb.ConnCase

  import TaskManager.AccountsFixtures

  alias TaskManager.Accounts.User

  @create_attrs %{
    name: "some name",
    email: "some@gmail.com"
  }
  @update_attrs %{
    name: "some updated name",
    email: "someupdated@gmail.com"
  }
  @invalid_attrs %{name: nil, email: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
