defmodule Signbank.Repo.Migrations.CreateSignRegions do
  use Ecto.Migration

  def change do
    create table(:sign_regions) do
      add :sign_id,
          references(:signs, on_delete: :nothing)

      add :region, :text
      timestamps(type: :utc_datetime)
    end
  end
end
