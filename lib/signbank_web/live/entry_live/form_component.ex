# TODO: this was from `gen.live`, look over it again
defmodule SignbankWeb.SignLive.FormComponent do
  use SignbankWeb, :live_component

  alias Signbank.Dictionary

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        <%= @title %>
        <:subtitle>Use this form to manage sign records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="sign-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:id_gloss]} label="ID gloss" />
        <.input field={@form[:annotation_id_gloss]} label="Annotation ID Gloss" />
        <.input field={@form[:translations]} label="translations" />

        <:actions>
          <.button phx-disable-with="Saving...">Save Sign</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{sign: sign} = assigns, socket) do
    changeset = Dictionary.change_sign(sign)

    {:ok,
     socket
     |> assign(assigns)
     |> assign_form(changeset)}
  end

  @impl true
  def handle_event("validate", %{"sign" => sign_params}, socket) do
    changeset =
      socket.assigns.sign
      |> Dictionary.change_sign(sign_params)
      |> Map.put(:action, :validate)

    {:noreply, assign_form(socket, changeset)}
  end

  def handle_event("save", %{"sign" => sign_params}, socket) do
    save_sign(socket, socket.assigns.action, sign_params)
  end

  defp save_sign(socket, :edit, sign_params) do
    case Dictionary.update_sign(socket.assigns.sign, sign_params) do
      {:ok, sign} ->
        notify_parent({:saved, sign})

        {:noreply,
         socket
         |> put_flash(:info, "Sign updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp save_sign(socket, :new, sign_params) do
    case Dictionary.create_sign(sign_params) do
      {:ok, sign} ->
        notify_parent({:saved, sign})

        {:noreply,
         socket
         |> put_flash(:info, "Sign created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign_form(socket, changeset)}
    end
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    assign(socket, :form, to_form(changeset))
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
