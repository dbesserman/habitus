defmodule Habitus.Core.Objective do
  use Ecto.Schema
  import Ecto.Changeset

  schema "objectives" do
    field :description, :string
    field :threshold, :integer

    timestamps()
  end

  def changeset(objective, attrs) do
    objective
    |> cast(attrs, [:description, :threshold])
    |> validate_required([:description, :threshold])
  end
end
