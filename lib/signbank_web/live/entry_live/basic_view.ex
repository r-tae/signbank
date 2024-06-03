defmodule SignbankWeb.SignLive.BasicView do
  use SignbankWeb, :live_view

  import SignbankWeb.Gettext
  alias Signbank.Dictionary

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(params, _, socket) do
    id_gloss = Map.get(params, "id")
    search_query = Map.get(params, "q")

    socket =
      assign(
        socket,
        :search_results,
        if is_nil(search_query) do
          []
        else
          {:ok, search_results} = Dictionary.get_sign_by_keyword!(search_query)
          search_results
        end
      )

    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:sign, Dictionary.get_sign_by_id_gloss!(id_gloss))
     |> assign(:search_query, search_query)}
  end

  # TODO: fix the page title
  defp page_title(:show), do: gettext("Show sign")
  defp page_title(:edit), do: gettext("Edit sign")
end
