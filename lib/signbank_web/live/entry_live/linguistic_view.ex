# TODO: this was from `gen.live`, look over it again
defmodule SignbankWeb.SignLive.LinguisticView do
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

  defp list_flags(flags) do
    with flags <- flags |> Map.filter(fn {_, v} -> v end) |> Map.keys() do
      Enum.join(
        if(Enum.empty?(flags), do: ["none"], else: flags),
        ","
      )
    end
  end

  defp generate_initial_final_text(initial, final) when initial == final or final == nil,
    do: "#{initial}"

  defp generate_initial_final_text(initial, final), do: "#{initial} → #{final}"

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

  # defp video_frame_type(sign) do
  #   type = video_frame_class(sign)

  #   if type == "se_only" do
  #     "Signed English only"
  #   else
  #     type
  #   end
  # end

  # defp bool_to_word(true), do: SignbankWeb.Gettext.gettext("yes")
  # defp bool_to_word(false), do: SignbankWeb.Gettext.gettext("no")
  # defp bool_to_word(_), do: SignbankWeb.Gettext.gettext("unknown")
end
