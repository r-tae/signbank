# TODO: this was from `gen.live`, look over it again
defmodule Signbank.DictionaryTest do
  use Signbank.DataCase

  alias Signbank.Dictionary

  describe "entries" do
    alias Signbank.Dictionary.Entry

    import Signbank.DictionaryFixtures

    @invalid_attrs %{}

    test "list_entries/0 returns all entries" do
      entry = entry_fixture()
      assert Dictionary.list_entries() == [entry]
    end

    test "get_entry!/1 returns the entry with given id" do
      entry = entry_fixture()
      assert Dictionary.get_entry!(entry.id) == entry
    end

    test "create_entry/1 with valid data creates a entry" do
      valid_attrs = %{}

      assert {:ok, %Entry{} = entry} = Dictionary.create_entry(valid_attrs)
    end

    test "create_entry/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Dictionary.create_entry(@invalid_attrs)
    end

    test "update_entry/2 with valid data updates the entry" do
      entry = entry_fixture()
      update_attrs = %{}

      assert {:ok, %Entry{} = entry} = Dictionary.update_entry(entry, update_attrs)
    end

    test "update_entry/2 with invalid data returns error changeset" do
      entry = entry_fixture()
      assert {:error, %Ecto.Changeset{}} = Dictionary.update_entry(entry, @invalid_attrs)
      assert entry == Dictionary.get_entry!(entry.id)
    end

    test "delete_entry/1 deletes the entry" do
      entry = entry_fixture()
      assert {:ok, %Entry{}} = Dictionary.delete_entry(entry)
      assert_raise Ecto.NoResultsError, fn -> Dictionary.get_entry!(entry.id) end
    end

    test "change_entry/1 returns a entry changeset" do
      entry = entry_fixture()
      assert %Ecto.Changeset{} = Dictionary.change_entry(entry)
    end
  end
end
