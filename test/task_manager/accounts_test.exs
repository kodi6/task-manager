defmodule TaskManager.AccountsTest do
  use TaskManager.DataCase

  alias TaskManager.Accounts

  describe "users" do
    alias TaskManager.Accounts.User

    @invalid_attrs %{name: nil, email: nil}

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{name: "some name", email: "some@gmail.com"}

      assert {:ok, %User{} = user} = Accounts.create_user(valid_attrs)
      assert user.name == "some name"
      assert user.email == "some@gmail.com"
    end
  end
end
