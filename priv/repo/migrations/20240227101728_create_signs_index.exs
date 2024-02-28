defmodule Signbank.Repo.Migrations.CreateSignsIndex do
  use Ecto.Migration

  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    # TODO: create constraint that prevents headsigns from having `variant_of_id_gloss`
    # TODO: and preferably vice versa

    create unique_index(:signs, [:id_gloss], concurrently: true)
  end
end
