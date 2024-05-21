defmodule VideoScroller do
  use SignbankWeb, :live_component

  def render(assigns) do
    assigns = assign(assigns, videos: Enum.concat([assigns.sign], assigns.sign.variants))
    # TODO: this implementation means we *require* javascript. I don't like this.
    # should refactor to use query params to control which video is selected
    ~H"""
    <div class="entry-page__videos_scroller">
      <style>
        .entry-page__videos_scroller {
          position:relative;
        }
        .entry-page__videos_scroller #next_variant,
        .entry-page__videos_scroller #previous_variant {
          position: absolute;
          z-index: 50;
          margin-top: 38%;
        }
        #next_variant { right: 0; }
        #previous_variant { left: 0; }
      </style>
      <button
        id="previous_variant"
        href="#"
        phx-click="previous"
        phx-target={@myself}
        disabled={@counter == 0}
      >
        <Heroicons.arrow_left class="icon--small" />
      </button>
      <button
        id="next_variant"
        href="#"
        phx-click="next"
        phx-target={@myself}
        disabled={@counter == Enum.count(@sign.variants)}
      >
        <Heroicons.arrow_right class="icon--small" />
      </button>
      <.video_frame id={"variant_video_#{@counter}"} sign={Enum.at(@videos, @counter)} />
    </div>
    """
  end

  def handle_event("previous", _, socket) do
    {:noreply, socket |> assign(counter: socket.assigns.counter - 1)}
  end

  def handle_event("next", _, socket) do
    # send(self(), {:updated_card, %{socket.assigns.card | title: title}})
    {:noreply, socket |> assign(counter: socket.assigns.counter + 1)}
  end

  defp video_frame_class(sign) do
    if String.starts_with?(sign.id_gloss, "FS") do
      "fingerspelled"
    else
      if sign.signed_english_only do
        "se_only"
      else
        Atom.to_string(sign.type)
      end
    end
  end

  defp video_frame(assigns) do
    ~H"""
    <div id={"video_#{@id}"} class={["video-frame", video_frame_class(@sign)]}>
      <%!-- TODO: refactor to support variant videos (we want to include the thing with the multiple videos, this may require svelte) --%>
      <div class="video-frame__video_wrapper">
        <video controls muted autoplay width="600">
          <source src={"#{Application.fetch_env!(:signbank, :media_url)}/#{Enum.at(@sign.videos,0).url}"} />
        </video>
        <div class="video-frame__sign-type">
          <%= if @sign.type == :headsign, do: "stem", else: "variant" %>
        </div>
        <.australia_map selected={@sign.regions} />
      </div>
    </div>
    """
  end
end
