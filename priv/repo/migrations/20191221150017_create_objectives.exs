defmodule Habitus.Repo.Migrations.CreateObjectives do
  use Ecto.Migration

  def change do
    create table(:objectives) do
      add(:description, :string, null: false)
      add(:threshold, :integer, null: false)

      timestamps()
    end
  end
end
