defmodule Habitus.Core do
  alias Habitus.Core.Objective
  alias Habitus.Repo

  def create_objective(attrs \\ %{}) do
    %Objective{}
    |> Objective.changeset(attrs)
    |> Repo.insert()
  end

  def change_objective(%Objective{} = objective) do
    Objective.changeset(objective, %{})
  end
end
