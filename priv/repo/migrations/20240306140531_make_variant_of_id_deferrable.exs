defmodule Signbank.Repo.Migrations.MakeVariantOfIdDeferrable do
  use Ecto.Migration

  # excellent_migrations:safety-assured-for-this-file raw_sql_executed

  @disable_ddl_transaction true
  @disable_migration_lock true

  def up do
    execute """
    ALTER TABLE "signs" ALTER CONSTRAINT "signs_variant_of_id_fkey" DEFERRABLE INITIALLY IMMEDIATE
    """
  end

  def down do
    execute """
    ALTER TABLE "signs" ALTER CONSTRAINT "signs_variant_of_id_fkey" NOT DEFERRABLE
    """
  end
end
