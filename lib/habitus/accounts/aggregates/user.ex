defmodule Habitus.Accounts.Aggregates.User do
  defstruct [
    :uuid,
    :username,
    :email,
    :hashed_password
  ]

  alias Habitus.Accounts.Commands.RegisterUser
  alias Habitus.Accounts.Events.UserRegistered

  @doc """
  Register a new user
  """
  def execute(%User{uuid: nil}, %RegisterUser{} = register) do
    %UserRegistered{
      user_uuid: register.user_uuid,
      username: register.username,
      email: register.email,
      hashed_password: hashed_password
    }
  end
end
