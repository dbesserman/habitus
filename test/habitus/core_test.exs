defmodule Habitus.CoreTest do
  use Habitus.DataCase, async: true

  alias Habitus.Core

  describe "objectives" do
    @valide_attrs %{description: "quit smoking", threshold: 0}
    @invalid_attrs %{}

    test "create_objective/2 with valid attributes creates a video" do
      assert {:ok, objective} = Core.create_objective(@valide_attrs)
      assert objective.description == "quit smoking"
      assert objective.threshold == 0
    end

    test "create_objective/2 with invalid data returns an error changeset" do
      assert {:error, %Ecto.Changeset{} = changeset} = Core.create_objective(@invalid_attrs)
      assert ["can't be blank"] = errors_on(changeset).description
      assert ["can't be blank"] = errors_on(changeset).threshold
    end

    test "change_objective/1 returns a changeset" do
      objective = objective_fixture()

      assert %Ecto.Changeset{} = Core.change_objective(objective)
    end
  end
end
