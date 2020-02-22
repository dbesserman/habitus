defmodule HabitusWeb.UserController do
  use HabitusWeb, :controller

  alias Habitus.Accounts
  alias Habitus.Accounts.Projections.User

  action_fallback(HabitusWeb.FallbackController)

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Accounts.register_user(user_params) do
      conn
      |> put_status(:created)
      |> render("show.html", user: user)
    end
  end
end
