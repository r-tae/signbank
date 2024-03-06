defmodule Signbank.Repo.Migrations.MakeVariantOfIdDeferrable do
  use Ecto.Migration

  def change do
    execute "SET CONSTRAINTS signs_variant_of_id_fkey DEFERRABLE INITIALLY IMMEDIATE"
  end
end
