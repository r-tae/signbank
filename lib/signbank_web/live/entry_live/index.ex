# TODO: this was from `gen.live`, look over it again
defmodule SignbankWeb.EntryLive.Index do
  use SignbankWeb, :live_view

  alias Signbank.Dictionary
  alias Signbank.Dictionary.Sign

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :entries, Dictionary.list_entries())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Entry")
    |> assign(:entry, Dictionary.get_entry_by_id_gloss!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Entry")
    |> assign(:entry, %Sign{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Entries")
    |> assign(:entry, nil)
  end

  @impl true
  def handle_info({SignbankWeb.EntryLive.FormComponent, {:saved, entry}}, socket) do
    {:noreply, stream_insert(socket, :entries, entry)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    entry = Dictionary.get_entry!(id)
    {:ok, _} = Dictionary.delete_entry(entry)

    {:noreply, stream_delete(socket, :entries, entry)}
  end
end
