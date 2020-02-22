defmodule Habitus.Router do
  use Commanded.Commands.Router

  alias Habitus.Accounts.Commands.RegisterUser
  alias Habitus.Accounts.Aggregates.User

  identify User, by: :user_uuid, prefix: "user-"

  dispatch [
    RegisterUser
  ], to: User
end
