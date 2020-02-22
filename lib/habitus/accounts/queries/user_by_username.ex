defmodule Habitus.Accounts.Queries.UserByUsername do
  import Ecto.Query

  alias Habitus.Accounts.Projections.User

  def query(username) do
    from u in User,
      where: u.username == ^username
  end
end
