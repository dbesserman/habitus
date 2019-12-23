defmodule Habitus.Repo.Migrations.CreateObjectiveEvents do
  use Ecto.Migration

  def change do
    create table(:objective_events) do
      add :objective_id, references(:objectives)

      timestamps()
    end
  end
end
