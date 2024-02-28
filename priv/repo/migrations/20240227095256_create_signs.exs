defmodule Signbank.Repo.Migrations.CreateSigns do
  use Ecto.Migration

  def change do
    create table(:signs) do
      add :id_gloss, :string
      add :type, :string
      add :annotation_id_gloss, :string
      add :translations, {:array, :string}
      add :legacy_id, :integer
      add :published, :boolean, default: false, null: false
      add :proposed_new_sign, :boolean, default: false

      add :compound, :text
      add :hamnosys, :text

      add :phonology, :map
      add :morphology, :map

      add :variant_of_id,
          references(:signs, on_delete: :nothing)

      add :asl_gloss, :string, null: true
      add :bsl_gloss, :string, null: true
      add :iconicity, :string
      add :is_asl_loan, :boolean, null: true
      add :is_bsl_loan, :boolean, null: true
      add :legacy_sign_number, :integer
      add :signed_english_gloss, :string, null: true
      add :signed_english_only, :boolean, null: true

      timestamps(type: :utc_datetime)
    end
  end
end
