defmodule Signbank.Dictionary.Phonology do
  @moduledoc """
  The phonology of a sign, actually stored as JSON in the database
  """
  use Ecto.Schema
  import Ecto.Changeset

  embedded_schema do
    field :dominant_initial_handshape, :string
    field :dominant_final_handshape, :string
    field :dominant_initial_interacting_handpart, :string
    field :dominant_final_interacting_handpart, :string
    field :dominant_initial_finger_hand_orientation, :string
    field :dominant_final_finger_hand_orientation, :string
    field :subordinate_initial_handshape, :string
    field :subordinate_final_handshape, :string
    field :subordinate_initial_interacting_handpart, :string
    field :subordinate_final_interacting_handpart, :string
    field :subordinate_initial_finger_hand_orientation, :string
    field :subordinate_final_finger_hand_orientation, :string
    field :initial_primary_location, :string
    field :final_primary_location, :string
    field :movement_dominant_only, :boolean
    field :movement_symmetrical, :boolean
    field :movement_parallel, :boolean
    field :movement_alternating, :boolean
    field :movement_away, :boolean
    field :movement_towards, :boolean
    field :movement_cross, :boolean
    field :movement_direction, :string
    field :movement_path, :string
    field :movement_repeated, :boolean
    field :movement_forearm_rotation, :boolean
    field :movement_wrist_nod, :boolean
    field :movement_fingers_straighten, :boolean
    field :movement_fingers_wiggle, :boolean
    field :movement_fingers_crumble, :boolean
    field :movement_fingers_bend, :boolean
    field :change_handshape, :boolean
    field :change_open, :boolean
    field :change_close, :boolean
    field :change_orientation, :boolean
    field :contact_start, :boolean
    field :contact_end, :boolean
    field :contact_during, :boolean
    field :contact_location, :boolean
    field :contact_body, :boolean
    field :contact_hands, :boolean

    # TODO: change to enum
    field :handedness, :string
    # TODO: change to enum
    field :repetition_type, :string
    field :loc_rightside_or_leftside, :string
  end

  def changeset(phonology, attrs) do
    phonology
    |> cast(attrs, [
      :dominant_initial_handshape,
      :dominant_final_handshape,
      :dominant_initial_interacting_handpart,
      :dominant_final_interacting_handpart,
      :dominant_initial_finger_hand_orientation,
      :dominant_final_finger_hand_orientation,
      :subordinate_initial_handshape,
      :subordinate_final_handshape,
      :subordinate_initial_interacting_handpart,
      :subordinate_final_interacting_handpart,
      :subordinate_initial_finger_hand_orientation,
      :subordinate_final_finger_hand_orientation,
      :initial_primary_location,
      :final_primary_location,
      :movement_dominant_only,
      :movement_symmetrical,
      :movement_parallel,
      :movement_alternating,
      :movement_away,
      :movement_towards,
      :movement_cross,
      :movement_direction,
      :movement_path,
      :movement_repeated,
      :movement_forearm_rotation,
      :movement_wrist_nod,
      :movement_fingers_straighten,
      :movement_fingers_wiggle,
      :movement_fingers_crumble,
      :movement_fingers_bend,
      :change_handshape,
      :change_open,
      :change_close,
      :change_orientation,
      :contact_start,
      :contact_end,
      :contact_during,
      :contact_location,
      :handedness,
      :repetition_type,
      :loc_rightside_or_leftside
    ])
  end
end
