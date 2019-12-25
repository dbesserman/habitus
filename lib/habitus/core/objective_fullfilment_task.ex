defmodule Habitus.Core.ObjectiveFulfillmentTask do
  use Task

  alias Habitus.Core

  def start_link() do
    Task.start_link(__MODULE__, :run, [])  
  end

  def run() do
    Core.list_objectives(:yesterday)
    |> Enum.each(fn obj -> Core.evaluate_objective_fullfilment(obj) end)
  end
end
