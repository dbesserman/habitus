defmodule HabitusWeb.ObjectiveEventController do
  use HabitusWeb, :controller

  alias Habitus.Core

  def create(conn, %{"objective_id" => objective_id}) do
    Core.get_objective!(objective_id)
    |> Core.create_objective_event()

    redirect(conn, to: Routes.page_path(conn, :index))
  end
end
