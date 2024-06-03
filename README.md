# Signbank

To start your Phoenix server:

  * Run `mix setup` to install and setup dependencies
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix


## Deployment

Signbank has been developed for the Australian Research Data Common's cloud,
[Nectar](https://ardc.edu.au/services/ardc-nectar-research-cloud/). The deployment
scripts should work out-of-the-box with any other OpenStack cloud (a popular choice
for national research infrastructure, some universities have their own OS cloud as
well).

## Testing

As of June 2024, Signbank has no useful automated tests. The automatic build/deploy
does find some issues automatically, and of course new builds are tested manually,
but smoke and unit tests would be a meaningful upgrade.
