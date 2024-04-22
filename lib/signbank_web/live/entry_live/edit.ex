defmodule SignbankWeb.SignLive.Edit do
  use SignbankWeb, :live_view
  alias Signbank.Dictionary

  @impl true
  def mount(_params, _session, socket) do
    socket =
      socket
      |> allow_upload(:image,
        accept: ~w(.jpg .jpeg .png),
        max_entries: 1,
        external: &presign_upload/2
      )

    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id_gloss}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, "edit entry")
     |> assign(:sign, Dictionary.get_sign_by_id_gloss!(id_gloss))}
  end

  # def handle_event("validate", _, socket) do
  #   {:noreply, socket}
  # end

  # def handle_event("save", %{"menu_item" => menu_item_params}, socket) do
  #   uploaded_files =
  #     consume_uploaded_entries(socket, :image, fn _, entry ->
  #       {:ok, S3Uploader.entry_url(entry)}
  #     end)

  #   menu_item_params =
  #     case Enum.empty?(uploaded_files) do
  #       true -> menu_item_params
  #       false -> Map.put(menu_item_params, "image", uploaded_files |> List.first())
  #     end

  #   socket =
  #     case Context.create_menu_item(menu_item_params) do
  #       {:ok, _} ->
  #         socket
  #         |> put_flash(:info, "menu_item created")
  #         |> push_patch(to: "/success")

  #       _ ->
  #         socket
  #         |> put_flash(:error, "Could not create a new menu_item")
  #     end
  # end

  defp presign_upload(entry, %{assigns: %{uploads: uploads}} = socket) do
    meta = SimpleS3Upload.meta(entry, uploads)
    {:ok, meta, socket}
  end
end
