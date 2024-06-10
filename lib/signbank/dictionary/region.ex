defmodule Signbank.Dictionary.SignRegion do
  @moduledoc """
  A single region for a sign.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "sign_regions" do
    belongs_to :sign, Signbank.Dictionary.Sign

    field :region, Ecto.Enum,
      values: [
        :no_region,
        :australia_wide,
        :northern,
        :queensland,
        :new_south_wales,
        :southern,
        :victoria,
        :western_australia,
        :south_australia,
        :tasmania
      ]

    timestamps()
  end

  @doc false
  def changeset(definition, attrs) do
    required_fields = [
      :sign_id,
      :region
    ]

    definition
    |> cast(attrs, required_fields)
    |> validate_required(required_fields)
    |> unique_constraint([:sign_id, :region], name: "definition_pos_unique_index")
  end
end
