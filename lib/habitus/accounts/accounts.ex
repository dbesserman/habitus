defmodule  Habitus.Accounts do
  alias Habitus.Accounts.Commands.RegisterUser
  alias Habitus.Accounts.Projections.User
  alias Habitus.Accounts.Queries.{UserByEmail, UserByUsername}
  alias Habitus.Repo
  alias Habitus.App

  def register_user(attrs \\ %{}) do
    uuid = UUID.uuid4()

    register_user =
      attrs
      |> RegisterUser.new()
      |> RegisterUser.assign_uuid(uuid)
      |> RegisterUser.downcase_username()
      |> RegisterUser.downcase_email()
      |> RegisterUser.hash_password()

    with :ok <- App.dispatch(register_user, consistency: :strong) do
      get(User, uuid)
    end
  end

  def user_by_email(email) when is_binary(email) do
    email
    |> String.downcase()
    |> UserByEmail.query()
    |> Repo.one()
  end

  def user_by_username(username) when is_binary(username) do
    username
    |> String.downcase()
    |> UserByUsername.query()
    |> Repo.one()
  end

  defp get(schema, uuid) do
    case Repo.get(schema, uuid) do
      nil -> {:error, :not_found}
      projection -> {:ok, projection}
    end
  end
end
