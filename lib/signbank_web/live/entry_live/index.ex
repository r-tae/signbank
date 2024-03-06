# TODO: this was from `gen.live`, look over it again
defmodule SignbankWeb.SignLive.Index do
  use SignbankWeb, :live_view

  alias Signbank.Dictionary
  alias Signbank.Dictionary.Sign

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :signs, Dictionary.list_signs())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Sign")
    |> assign(:sign, Dictionary.get_sign_by_id_gloss!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Sign")
    |> assign(:sign, %Sign{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Entries")
    |> assign(:sign, nil)
  end

  @impl true
  def handle_info({SignbankWeb.SignLive.FormComponent, {:saved, sign}}, socket) do
    {:noreply, stream_insert(socket, :signs, sign)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    sign = Dictionary.get_sign!(id)
    {:ok, _} = Dictionary.delete_sign(sign)

    {:noreply, stream_delete(socket, :signs, sign)}
  end
end
