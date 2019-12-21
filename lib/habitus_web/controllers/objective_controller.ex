defmodule HabitusWeb.ObjectiveController do
  use HabitusWeb, :controller

  alias Habitus.Core
  alias Habitus.Core.Objective

  def new(conn, _) do
    changeset = Core.change_objective(%Objective{})

    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"objective" => objective_params}) do
    case Core.create_objective(objective_params) do
      {:ok, objective} ->
        encouragement =
          "Bon courrage pour #{objective.description} moins de #{objective.threshold} par jour"

        conn
        |> put_flash(:info, encouragement)
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end
end
