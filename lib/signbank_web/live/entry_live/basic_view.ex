# TODO: this was from `gen.live`, look over it again
defmodule SignbankWeb.SignLive.BasicView do
  use SignbankWeb, :live_view
  import SignbankWeb.Gettext
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
     |> assign(:sign, Dictionary.get_sign_by_id_gloss!(id_gloss))}
  end

  # TODO: fix the page title
  defp page_title(:show), do: gettext("Show sign")
  defp page_title(:edit), do: gettext("Edit sign")

  # defp video_frame_class(sign) do
  #   if String.starts_with?(sign.id_gloss, "FS") do
  #     "fingerspelled"
  #   else
  #     if sign.signed_english_only do
  #       "se_only"
  #     else
  #       Atom.to_string(sign.type)
  #     end
  #   end
  # end

  # defp video_frame(assigns) do
  #   ~H"""
  #   <div class={["video-frame", video_frame_class(@sign)]}>
  #     <%!-- TODO: refactor to support variant videos (we want to include the thing with the multiple videos, this may require svelte) --%>
  #     <div class="video-frame__video_wrapper">
  #       <video controls muted autoplay width="600">
  #         <%!-- TODO: move this to an envvar --%>
  #         <source src={"#{Application.fetch_env!(:signbank, :media_url)}/#{Enum.at(@sign.videos,0).url}"} />
  #       </video>
  #       <div class="video-frame__sign-type"><%= @sign.type %></div>
  #       <.australia_map selected={@sign.regions} />
  #     </div>
  #   </div>
  #   """
  # end
end
