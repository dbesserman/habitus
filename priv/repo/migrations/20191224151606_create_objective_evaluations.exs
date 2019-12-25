defmodule Habitus.Repo.Migrations.CreateObjectiveEvaluations do
  use Ecto.Migration

  def change do
    create table(:objective_evaluations) do
      add :score, :integer, null: false
      add :objective_id, references(:objectives)

      timestamps()
    end
  end
end
