defmodule Signbank.Repo.Migrations.AddReligionFields do
  use Ecto.Migration

  def change do
    alter table(:signs) do
      add :religion_catholic, :boolean, null: true
      add :religion_catholic_school, :boolean, null: true
      add :religion_jehovahs_witness, :boolean, null: true
      add :religion_other_religion, :boolean, null: true
      add :religion_anglican, :boolean, null: true
    end
  end
end
