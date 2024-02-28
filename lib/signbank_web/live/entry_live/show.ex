# TODO: this was from `gen.live`, look over it again
defmodule SignbankWeb.EntryLive.Show do
  use SignbankWeb, :live_view

  alias Signbank.Dictionary

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id_gloss}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:entry, Dictionary.get_entry_by_id_gloss!(id_gloss))}
  end

  defp page_title(:show), do: "Show Entry"
  defp page_title(:edit), do: "Edit Entry"
end
