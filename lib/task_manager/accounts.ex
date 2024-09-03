defmodule TaskManager.Accounts do
  @moduledoc """
  The Accounts context.
  """

  import Ecto.Query, warn: false
  alias TaskManager.Repo

  alias TaskManager.Accounts.User

  @doc"""
  Create a User.
  """

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

end
