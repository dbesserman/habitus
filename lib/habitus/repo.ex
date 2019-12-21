defmodule Habitus.Repo do
  use Ecto.Repo,
    otp_app: :habitus,
    adapter: Ecto.Adapters.Postgres
end
