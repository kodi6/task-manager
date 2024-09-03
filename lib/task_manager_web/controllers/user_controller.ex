defmodule TaskManagerWeb.UserController do
  use TaskManagerWeb, :controller

  alias TaskManager.Accounts
  alias TaskManager.Accounts.User

  action_fallback TaskManagerWeb.FallbackController

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.create_user(user_params) do
      conn
      |> put_status(:created)
      # |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

end
