defmodule Habitus.Core.ObjectiveEvaluation do
  use Ecto.Schema
  import Ecto.Changeset

  schema "objective_evaluations" do
    field :score, :integer

    belongs_to :objective, Habitus.Core.Objective

    timestamps()
  end

  def changeset(objective_evaluation, attrs \\ %{}) do
    objective_evaluation
    |> cast(attrs, [:score])
    |> validate_required([:score])
    |> assoc_constraint(:objective)
  end
end
