defmodule VideoScroller do
  @moduledoc """
  Shows a sign and its variants in a carosel.
  """
  use SignbankWeb, :live_component

  def render(assigns) do
    assigns = assign(assigns, videos: Enum.concat([assigns.sign], assigns.sign.variants))
    # TODO: this implementation means we *require* javascript. I don't like this.
    # should refactor to use query params to control which video is selected
    ~H"""
    <div class="entry-page__videos_scroller">
      <button
        :if={not Enum.empty?(@sign.variants)}
        id="previous_variant"
        class="entry-page__videos_scroller_slide_buttons"
        href="#"
        phx-click="previous"
        phx-target={@myself}
        disabled={@counter == 0}
        aria-label="previous variant"
      >
        <Heroicons.arrow_left class="icon--small" />
      </button>
      <button
        :if={not Enum.empty?(@sign.variants)}
        id="next_variant"
        class="entry-page__videos_scroller_slide_buttons"
        href="#"
        phx-click="next"
        phx-target={@myself}
        disabled={@counter == Enum.count(@sign.variants)}
        aria-label="next variant"
      >
        <Heroicons.arrow_right class="icon--small" />
      </button>
      <.video_frame id={"variant_video_#{@sign.id}_#{@counter}"} sign={Enum.at(@videos, @counter)} />
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
    if sign.english_entry do
      "english_entry"
    else
      if sign.is_signed_english_only do
        "se_only"
      else
        Atom.to_string(sign.type)
      end
    end
  end

  defp video_frame(assigns) do
    # TODO: refactor along with linguistic_view.html.heex
    ~H"""
    <div id={"video_#{@id}"} class={["video-frame", video_frame_class(@sign)]}>
      <%!-- TODO: refactor to support variant videos (we want to include the thing with the multiple videos, this may require svelte) --%>
      <div class="video-frame__video_wrapper">
        <video controls muted autoplay width="600">
          <source src={"#{Application.fetch_env!(:signbank, :media_url)}/#{Enum.at(@sign.videos,0).url}"} />
        </video>
        <div class="video-frame__sign-type">
          <%= cond do
            @sign.english_entry -> "fingerspelled"
            @sign.is_signed_english_only -> "se_only"
            @sign.type == :citation -> "citation"
            @sign.type == :variant -> "variant"
          end %>
        </div>
        <.australia_map selected={@sign.regions} />
      </div>
    </div>
    """
  end
end
