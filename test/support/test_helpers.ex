defmodule Habitus.TestHelpers do
  alias Habitus.Core
  alias Habitus.Core.Objective

  def objective_fixture(attrs \\ %{}) do
    attrs = Enum.into(attrs, %{description: "quit smoking", threshold: 0})

    {:ok, objective} = Core.create_objective(attrs)

    objective
  end

  def objective_event_fixture(objective, attrs \\ %{}) do
    {:ok, objective_event} = Core.create_objective_event(objective, attrs)

    objective_event
  end

  def objective_evaluation_fixture(objective, attrs \\ %{}) do
    {:ok, objective_evaluation} = Core.create_objective_evaluation(objective, attrs)

    objective_evaluation
  end
end
