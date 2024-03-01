defmodule Signbank.Repo.Migrations.CreateDefinitionsIndex do
  use Ecto.Migration

  @disable_ddl_transaction true
  @disable_migration_lock true

  def change do
    create unique_index(
             :definitions,
             [:sign_id, :role, :pos],
             name: :definition_pos_unique_index,
             concurrently: true
           )
  end
end
