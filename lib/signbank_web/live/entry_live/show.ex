# TODO: this was from `gen.live`, look over it again
defmodule SignbankWeb.EntryLive.Show do
  use SignbankWeb, :live_view

  alias Signbank.Dictionary

  @role_order [
    :general,
    :auslan,
    :noun,
    :verb,
    :modifier,
    :augment,
    :deictic,
    :question,
    :interact,
    :popular_explanation,
    :note,
    :privatenote
  ]

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

  defp group_definitions_by_role(definitions) do
    definitions
    |> Enum.group_by(fn def -> def.role end)
    |> Enum.to_list()
    |> Enum.sort_by(fn {role, _defs} ->
      Enum.find_index(
        @role_order,
        fn x -> x == role end
      )
    end)
  end

  def definitions(assigns) do
    assigns =
      assign(
        assigns,
        :def_groups,
        group_definitions_by_role(assigns.definitions)
      )

    ~H"""
    <div>
      <%= for {role, definitions} <- @def_groups do %>
        <%!-- TODO: style this --%>
        <%!-- TODO: gettext `<%= Gettext.gettext(SignbankWeb.Gettext, "definition-role_#{role}") %>` --%>
        <%= role %>
        <ol>
          <%= for definition <- definitions do %>
            <li><%= definition.text %></li>
          <% end %>
        </ol>
      <% end %>
    </div>
    """
  end
end
