defmodule Habitus.CoreTest do
  use Habitus.DataCase, async: true

  alias Habitus.Core
  alias Habitus.Core.ObjectiveEvent

  @time_zone "Europe/Paris"

  describe "objectives" do
    alias Habitus.Core.Objective

    @valide_attrs %{description: "quit smoking", threshold: 0}
    @invalid_attrs %{}

    test "list_objectives(:today) returns all objectives" do
      %Objective{id: id1} = objective_fixture()
      assert [%Objective{id: ^id1} = objective] = Core.list_objectives(:today)

      %Objective{id: id2} = objective_fixture()
      assert [%Objective{id: ^id1}, %Objective{id: ^id2}] = Core.list_objectives(:today)
    end

    test "list_objectives(:today) preloads the today's objective_events" do
      now = Timex.now(@time_zone)
      yesterday = Timex.shift(now, days: -1)
      tomorrow = Timex.shift(now, days: 1)
      objective = objective_fixture()
      todays_objective_event = objective_event_fixture(objective, %{inserted_at: now})

      objective_event_fixture(objective, %{inserted_at: yesterday})
      objective_event_fixture(objective, %{inserted_at: tomorrow})

      [returned_objective] = Core.list_objectives(:today)

      assert [%ObjectiveEvent{id: returned_objective_event_id}] = returned_objective.objective_events
      assert returned_objective_event_id == todays_objective_event.id
    end

    test "list_objectives(:yesterday) preloads the yesterday's objective_events" do
      now = Timex.now(@time_zone)
      yesterday = Timex.shift(now, days: -1)
      two_days_ago = Timex.shift(now, days: -2)
      objective = objective_fixture()

      objective_event_fixture(objective, %{inserted_at: now})
      yesterday_objective_event = objective_event_fixture(objective, %{inserted_at: yesterday})
      objective_event_fixture(objective, %{inserted_at: two_days_ago})

      [returned_objective] = Core.list_objectives(:yesterday)

      assert [%ObjectiveEvent{id: returned_objective_event_id}] = returned_objective.objective_events
      assert returned_objective_event_id == yesterday_objective_event.id
    end

    test "get_objective!/1 returns an objective if the id is valid" do
      objective = objective_fixture()
      assert objective == Core.get_objective!(objective.id)
    end

    test "get_objective!/1 raises an error if the id is invalid" do
      assert_raise Ecto.NoResultsError, fn ->
        Core.get_objective!(1000)
      end
    end

    test "create_objective/1 with valid attributes creates an objective" do
      assert {:ok, objective} = Core.create_objective(@valide_attrs)
      assert objective.description == "quit smoking"
      assert objective.threshold == 0
    end

    test "create_objective/1 with invalid data returns an error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Core.create_objective(@invalid_attrs)
      assert ["can't be blank"] = errors_on(changeset).description
      assert ["can't be blank"] = errors_on(changeset).threshold
    end

    test "change_objective/1 returns a changeset" do
      objective = objective_fixture()

      assert %Ecto.Changeset{} = Core.change_objective(objective)
    end
  end

  describe "objective_events" do
    test "create_objective_event/2 with valid attributes creates an objective_event" do
      objective = objective_fixture()
      assert {:ok, %ObjectiveEvent{}} = Core.create_objective_event(objective)
    end
  end
end
