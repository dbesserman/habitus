defmodule Habitus.Core.ObjectiveEvent do
  use Ecto.Schema
  import Ecto.Changeset

  schema "objective_events" do
    belongs_to :objective, Habitus.Core.Objective 
    
    timestamps()
  end

  def changeset(objective_event, attrs \\ %{}) do
    objective_event
    |> cast(attrs, [:objective_id])
    |> assoc_constraint(:objective)
  end
end
