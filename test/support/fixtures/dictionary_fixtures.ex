# TODO: this was from `gen.live`, look over it again
defmodule Signbank.DictionaryFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Signbank.Dictionary` context.
  """

  @doc """
  Generate a entry.
  """
  def entry_fixture(attrs \\ %{}) do
    {:ok, entry} =
      attrs
      |> Enum.into(%{})
      |> Signbank.Dictionary.create_entry()

    entry
  end
end
