defmodule Habitus.Accounts.Queries.UserByEmail do
  import Ecto.Query

  alias Habitus.Accounts.Projections.User

  def query(email) do
    from u in User,
      where: u.email == ^email
  end
end
