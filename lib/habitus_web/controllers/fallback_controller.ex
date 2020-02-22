defmodule HabitusWeb.FallbackController do
  use HabitusWeb, :controller

  def call(conn, {:error, :validation_failure, errors}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(HabitusWeb.ValidationView)
    |> render("error.json", errors: errors)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(HabitusWeb.ErrorView)
    |> render(:"404")
  end
end
