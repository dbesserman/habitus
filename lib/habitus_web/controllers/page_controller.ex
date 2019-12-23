defmodule HabitusWeb.PageController do
  use HabitusWeb, :controller

  alias Habitus.Core

  def index(conn, _params) do
    objectives = Core.list_objectives()
    render(conn, "index.html", objectives: objectives)
  end
end
