defmodule MM.Repo do
  use Ecto.Repo,
    otp_app: :mm,
    adapter: Ecto.Adapters.Postgres
end
