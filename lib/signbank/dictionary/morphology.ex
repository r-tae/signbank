defmodule Signbank.Dictionary.Morphology do
  @moduledoc """
  The morphology of a sign, actually stored as JSON in the database
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :directional, :boolean
    field :begin_directional, :boolean
    field :end_directional, :boolean
    field :orientating, :boolean
    field :locating_and_directional, :boolean
    field :body_locating, :boolean
    field :hamnosys, :string

    field :initialism, :string
    field :alphabet, :string
    field :abbreviation, :string

    # TODO: eventually we would like to refactor this information into a table, to properly link signs
    field :blend_of, :string
    field :calque_of, :string
    field :compound_of, :string
    field :idiom_of, :string
    field :multi_sign_expression, :string
  end

  def changeset(phonology, attrs) do
    phonology
    |> cast(attrs, [
      :directional,
      :begin_directional,
      :end_directional,
      :orientating,
      :locating_and_directional,
      :body_locating,
      :hamnosys,
      :blend_of,
      :calque_of,
      :compound_of,
      :initialism,
      :alphabet,
      :abbreviation,
      :idiom_of,
      :multi_sign_expression
    ])
  end
end
