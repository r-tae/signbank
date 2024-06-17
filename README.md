# Signbank

To start signbank:
  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


## Deployment

Auslan Signbank is hosted on an Ubuntu VM on the Australian Research Data Common's cloud,
[Nectar](https://ardc.edu.au/services/ardc-nectar-research-cloud/). It should work with any Linux server, although you will need to install and setup some things manually:
- Postgres
- A reverse proxy, since it is not built to communicate over HTTPS directly. I recommend [Caddy](https://caddyserver.com/) since it handles TLS certificates automatically. Nginx will work if you'd prefer.
- Tailscale (optional). Allows you to connect to the database from your local machine, without exposing it to the internet.
