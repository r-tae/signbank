defmodule Signbank.Repo.Migrations.MakeVariantOfIdDeferrable do
  use Ecto.Migration

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
