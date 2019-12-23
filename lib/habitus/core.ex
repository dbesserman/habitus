defmodule Habitus.Core do
  import Ecto.Query, warn: false

  alias Habitus.Core.{Objective, ObjectiveEvent}
  alias Habitus.Repo

  def get_objective!(id) do
    Repo.get!(Objective, id)
  end

  def list_objectives() do
    Objective
    |> Repo.all()
    |> Repo.preload(:objective_events)
  end

  def list_objective_objective_events(%Objective{} = objective) do
    ObjectiveEvent
    |> obective_objective_events_query(objective)
    |> Repo.all()
  end

  def create_objective(attrs \\ %{}) do
    %Objective{}
    |> Objective.changeset(attrs)
    |> Repo.insert()
  end

  def change_objective(%Objective{} = objective) do
    Objective.changeset(objective, %{})
  end

  def create_objective_event(objective) do
    %ObjectiveEvent{}
    |> ObjectiveEvent.changeset()
    |> Ecto.Changeset.put_assoc(:objective, objective)
    |> Repo.insert()
  end

  defp obective_objective_events_query(query, %Objective{id: objective_id}) do
    from(objective_event in query, where: objective_event.objective_id == ^objective_id)
  end
end
