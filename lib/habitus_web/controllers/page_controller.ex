defmodule HabitusWeb.PageController do
  use HabitusWeb, :controller

  alias Habitus.Core

  def index(conn, _params) do
    objectives = Core.list_objectives(:today)
    total_score = Core.total_score()
    render(conn, "index.html", objectives: objectives, total_score: total_score)
  end
end
