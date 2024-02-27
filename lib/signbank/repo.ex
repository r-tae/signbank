defmodule Signbank.Repo do
  use Ecto.Repo,
    otp_app: :signbank,
    adapter: Ecto.Adapters.Postgres
end
