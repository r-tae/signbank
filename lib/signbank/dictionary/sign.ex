defmodule Signbank.Dictionary.Sign do
  @moduledoc """
  A dictionary entry
  """
  use Ecto.Schema
  import Ecto.Changeset
  alias Signbank.Dictionary

  schema "signs" do
    field :type, Ecto.Enum, values: [:headsign, :variant]
    field :id_gloss, :string
    field :annotation_id_gloss, :string

    # TODO: uncomment this after adding %Region{}/SignRegion
    # many_to_many :regions, Dictionary.Region, join_through: Dictionary.SignRegion

    field :translations, {:array, :string}
    field :legacy_id, :integer
    field :published, :boolean, default: false
    field :proposed_new_sign, :boolean, default: false

    field :compound, :string
    field :hamnosys, :string

    # TODO: uncomment this after adding %Tag{}/SignTag
    # many_to_many :tags, Dictionary.Tag, join_through: Dictionary.SignTag

    embeds_one :phonology, Dictionary.Phonology
    embeds_one :morphology, Dictionary.Morphology

    # TODO: revisit this, it's not a foreign key in the database, I don't know how bad that is
    belongs_to :active_video, Dictionary.SignVideo,
      foreign_key: :active_video_id,
      references: :id

    # TODO: uncomment this after adding %SignVideo{}
    has_many :videos, Dictionary.SignVideo
    has_many :regions, Dictionary.SignRegion

    field :has_video?, :string, virtual: true
    field :has_definitions?, :string, virtual: true

    # If type == :headsign
    has_many :variants, Dictionary.Sign,
      foreign_key: :variant_of_id,
      references: :id

    # If type == :variant
    belongs_to :headsign, Dictionary.Sign,
      foreign_key: :variant_of_id,
      references: :id

    has_many :definitions, Dictionary.Definition

    # TODO: uncomment this after adding %Relation{}
    # has_many :relations, Dictionary.Relation, foreign_key: :sign_a_id

    # This was WIP nothingness
    # many_to_many :relations, Dictionary.Sign,
    #   join_through: Dictionary.Relation,
    #   join_keys: [sign_a_id_gloss: :id_gloss, sign_b_id_gloss: :id_gloss]

    field :asl_gloss, :string
    field :bsl_gloss, :string
    field :iconicity, Ecto.Enum, values: [:opaque, :obscure, :translucent, :transparent]
    field :is_asl_loan, :boolean
    field :is_bsl_loan, :boolean
    field :legacy_sign_number, :integer
    field :signed_english_gloss, :string
    field :signed_english_only, :boolean

    field :lexis_doubtful, :boolean
    field :lexis_proper_name, :boolean
    field :lexis_restricted, :boolean
    field :lexis_marginal, :boolean
    field :lexis_obsolete, :boolean
    field :lexis_technical, :boolean

    field :religion_catholic, :boolean
    field :religion_catholic_school, :boolean
    field :religion_jehovahs_witness, :boolean
    field :religion_other_religion, :boolean
    field :religion_anglican, :boolean

    timestamps()
  end

  def changeset(sign, attrs) do
    required_fields = [
      :type,
      :id_gloss,
      :annotation_id_gloss,
      :translations,
      :published
    ]

    optional_fields = [
      :legacy_id,
      :proposed_new_sign,
      :compound,
      :hamnosys,
      :variant_of_id,
      :active_video_id,
      :lexis_doubtful,
      :lexis_proper_name,
      :lexis_restricted,
      :lexis_marginal,
      :lexis_obsolete,
      :lexis_technical,
      :religion_catholic,
      :religion_catholic_school,
      :religion_jehovahs_witness,
      :religion_other_religion,
      :religion_anglican
    ]

    sign
    |> cast(attrs, required_fields ++ optional_fields)
    |> cast_embed(:phonology)
    |> cast_embed(:morphology)
    # |> then(fn changeset ->
    # changeset |> get_field(:definitions) |> IO.inspect()
    # changeset
    # end)
    |> validate_sign_type()
    |> validate_required(required_fields)
    # TODO: uncomment this
    # |> foreign_key_constraint(:variants, name: :signs_variant_of_fkey)
    |> unique_constraint(:id_gloss)
    |> assoc_constraint(:headsign)
    # |> assoc_constraint(:active_video_id)
    |> cast_assoc(:videos)

    # TODO: uncomment this
  end

  defp validate_sign_type(changeset) do
    type = get_field(changeset, :type)

    case type do
      :variant ->
        changeset
        |> guard_field_exists(:variant_of_id, "must be set when type is variant")

      # TODO: uncomment this
      # |> guard_field_not_exists(:definitions, "variant cannot have definitions")

      :headsign ->
        changeset
        |> guard_field_not_exists(:variant_of_id, "cannot be set when type is not variant")

      _ ->
        changeset
    end
  end

  # These guard functions are syntactic sugar for adding errors to the changeset
  defp guard_field_exists(changeset, field, message) do
    case get_field(changeset, field) do
      nil -> add_error(changeset, field, message)
      _ -> changeset
    end
  end

  defp guard_field_not_exists(changeset, field, message) do
    case get_field(changeset, field) do
      nil -> changeset
      [] -> changeset
      _ -> add_error(changeset, field, message)
    end
  end
end
