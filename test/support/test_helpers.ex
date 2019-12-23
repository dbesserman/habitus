defmodule Habitus.TestHelpers do
  alias Habitus.Core
  alias Habitus.Core.Objective

  def objective_fixture(attrs \\ %{}) do
    attrs = Enum.into(attrs, %{description: "quit smoking", threshold: 0})

    {:ok, objective} = Core.create_objective(attrs)

    objective
  end

  def objective_event_fixture(objective) do
    {:ok, objective_event} = Core.create_objective_event(objective)

    objective_event
  end
end
