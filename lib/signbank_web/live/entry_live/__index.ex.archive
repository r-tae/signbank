# TODO: this was from `gen.live`, look over it again
defmodule SignbankWeb.SignLive.Index do
  use SignbankWeb, :live_view
  import SignbankWeb.Gettext

  alias Signbank.Dictionary
  alias Signbank.Dictionary.Sign

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :signs, [])}
  end

  @impl true
  def handle_params(params, _url, socket) do
    page = Dictionary.list_signs(String.to_integer(Map.get(params, "page", "1")))

    {:noreply,
     socket
     |> assign(:page, page)
     |> apply_action(socket.assigns.live_action, params)
     |> stream(:signs, page, reset: true)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, gettext("Edit sign"))
    |> assign(:sign, Dictionary.get_sign_by_id_gloss!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, gettext("New sign"))
    |> assign(:sign, %Sign{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, gettext("List of entries"))
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
