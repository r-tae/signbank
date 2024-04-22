defmodule Signbank.Repo.Migrations.AddLexisFields do
  use Ecto.Migration

  def change do
    alter table(:signs) do
      add :lexis_doubtful, :boolean, null: true
      add :lexis_proper_name, :boolean, null: true
      add :lexis_restricted, :boolean, null: true
      add :lexis_marginal, :boolean, null: true
      add :lexis_obsolete, :boolean, null: true
      add :lexis_technical, :boolean, null: true
    end
  end
end
