defmodule Habitus.Core do
  import Ecto.Query, warn: false

  alias Habitus.Core.{Objective, ObjectiveEvent, ObjectiveEvaluation, ObjectiveFulfillmentTask}
  alias Habitus.Repo

  @time_zone "Europe/Paris"
  @success_score 10
  @failure_score -10

  def get_objective!(id) do
    Repo.get!(Objective, id)
  end

  def list_objectives(:today) do
    {beginning_of_today, end_of_today} = todays_boundaries()

    list_objectives(beginning_of_today, end_of_today)
  end

  def list_objectives(:yesterday) do
    {beginning_of_yesterday, end_of_yesterday} = yesterdays_boundaries()

    list_objectives(beginning_of_yesterday, end_of_yesterday)
  end

  def list_objective_objective_events(%Objective{} = objective) do
    ObjectiveEvent
    |> obective_objective_events_query(objective)
    |> Repo.all()
  end

  def create_objective(attrs \\ %{}) do
    %Objective{}
    |> Objective.changeset(attrs)
    |> Repo.insert()
  end

  def change_objective(%Objective{} = objective) do
    Objective.changeset(objective, %{})
  end

  def create_objective_event(objective, attrs \\ %{}) do
    %ObjectiveEvent{}
    |> ObjectiveEvent.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:objective, objective)
    |> Repo.insert()
  end

  def evaluate_objective_fullfilment(objective) do
    score =
      objective
      |> success?()
      |> objective_score()

    create_objective_evaluation(objective, %{score: score})
  end

  def total_score() do
    Repo.one(from oe in ObjectiveEvaluation, select: sum(oe.score)) || 0
  end

  defp list_objectives(events_beginning_datetime, events_end_datetime) do
    Objective
    |> Repo.all()
    |> Repo.preload(objective_events: objective_events_within_time_rage_query(events_beginning_datetime, events_end_datetime))
  end

  def create_objective_evaluation(objective, attrs \\ %{}) do
    %ObjectiveEvaluation{}
    |> ObjectiveEvaluation.changeset(attrs)
    |> Ecto.Changeset.put_assoc(:objective, objective)
    |> Repo.insert()
  end

  def start_yesterdays_objective_evaluation() do
    ObjectiveFulfillmentTask.start_link()
  end

  defp todays_boundaries() do
    now = Timex.now(@time_zone)

    {Timex.beginning_of_day(now), Timex.end_of_day(now)}
  end

  defp yesterdays_boundaries() do
    now = Timex.now(@time_zone)

    beginning_of_yesterday =
      now
      |> Timex.shift(days: -1)
      |> Timex.beginning_of_day()

    end_of_yesterday = Timex.end_of_day(beginning_of_yesterday)

    {beginning_of_yesterday, end_of_yesterday}
  end

  defp objective_events_within_time_rage_query(start_datetime, end_datetime) do
    from(oe in ObjectiveEvent, where: ^start_datetime < oe.inserted_at and oe.inserted_at < ^end_datetime)
  end

  defp obective_objective_events_query(query, %Objective{id: objective_id}) do
    from(objective_event in query, where: objective_event.objective_id == ^objective_id)
  end

  defp success?(objective) do
    Enum.count(objective.objective_events) <= objective.threshold
  end

  defp objective_score(true), do: @success_score
  defp objective_score(false), do: @failure_score
end
