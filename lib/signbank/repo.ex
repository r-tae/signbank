defmodule Signbank.Repo do
  use Ecto.Repo,
    otp_app: :signbank,
    adapter: Ecto.Adapters.Postgres

  use Scrivener, page_size: 25
end
