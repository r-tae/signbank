set dotenv-load := true
dev:
  iex -S mix phx.server

dbreset:
  mix ecto.reset
