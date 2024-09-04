defmodule TaskManagerWeb.Router do
  use TaskManagerWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, html: {TaskManagerWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TaskManagerWeb do
    pipe_through :api

    post "/users", UserController, :create

    post "/users/:user_id/tasks", TaskController, :create

    get "/users/:user_id/tasks", TaskController, :index

    get "/users/:user_id/tasks/:task_id", TaskController, :show

    put "/users/:user_id/tasks/:task_id", TaskController, :update

    delete "/users/:user_id/tasks/:task_id", TaskController, :delete
  end
end
