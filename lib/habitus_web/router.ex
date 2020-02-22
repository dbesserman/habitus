defmodule HabitusWeb.Router do
  use HabitusWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HabitusWeb do
    pipe_through :api

    post "/users", UserController, :create
  end

  scope "/", HabitusWeb do
    pipe_through :browser

    # get "/", PageController, :index
    # resources "/objectives", ObjectiveController, only: [:new, :create] do
    #   resources "/objective_events", ObjectiveEventController, only: [:create]
    # end
  end

  # Other scopes may use custom stacks.
  # scope "/api", HabitusWeb do
  #   pipe_through :api
  # end
end
