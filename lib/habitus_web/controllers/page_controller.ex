defmodule HabitusWeb.PageController do
  use HabitusWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
