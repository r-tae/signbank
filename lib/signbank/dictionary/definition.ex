defmodule Signbank.Dictionary.Definition do
  @moduledoc """
  A single definition for a sign. Usually text, can be a video
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "definitions" do
    belongs_to :sign, Signbank.Dictionary.Sign

    field :text, :string
    field :pos, :integer

    field :role, Ecto.Enum,
      values: [
        :general,
        :auslan,
        :noun,
        :verb,
        :modifier,
        :augment,
        :pointing_sign,
        :question,
        :interactive,
        :popular_explanation,
        :note,
        # TODO: move to text field
        :editor_note
      ]

    # TODO: figure out a way to handle SL definitions, probably can just set :language appropriately and have url field
    # ISO language code expected
    field :language, :string
    field :published, :boolean, default: false
    # TODO: add video relation

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(definition, attrs) do
    required_fields = [
      :sign_id,
      :text,
      :role,
      :language,
      :pos
    ]

    optional_fields = [
      :published
    ]

    definition
    |> cast(attrs, required_fields ++ optional_fields)
    |> validate_required(required_fields)
    |> unique_constraint([:sign_id, :role, :pos], name: "definition_pos_unique_index")
  end
end
