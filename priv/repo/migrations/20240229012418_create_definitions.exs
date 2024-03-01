defmodule Signbank.Repo.Migrations.CreateDefinitions do
  use Ecto.Migration

  def change do
    create table(:definitions) do
      add :sign_id,
          references(:signs, on_delete: :nothing)

      add :text, :text
      add :role, :string
      add :language, :string
      add :published, :boolean, default: false, null: false
      add :pos, :integer

      timestamps(type: :utc_datetime)
    end
  end
end
