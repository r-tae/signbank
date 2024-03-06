# TODO: this was from `gen.live`, look over it again
defmodule Signbank.DictionaryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Signbank.Dictionary` context.
  """

  @doc """
  Generate a sign.
  """
  def sign_fixture(attrs \\ %{}) do
    {:ok, sign} =
      attrs
      |> Enum.into(%{})
      |> Signbank.Dictionary.create_sign()

    sign
  end
end
