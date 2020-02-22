defmodule Habitus.Auth do
  @moduledoc """
  Boundary for authentication.
  Uses the bcrypt password hashing function.
  """

  def hash_password(password), do: Argon2.hash_pwd_salt(password)
end
