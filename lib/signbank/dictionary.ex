# TODO: this was from `gen.live`, look over it again
defmodule Signbank.Dictionary do
  @moduledoc """
  The Dictionary context.
  """

  import Ecto.Query, warn: false
  alias Signbank.Repo

  alias Signbank.Dictionary.Sign

  @doc """
  Returns the list of signs.

  ## Examples

      iex> list_signs()
      [%Sign{}, ...]

  """
  def list_signs do
    Repo.all(Sign)
  end

  @doc """
  Returns a paginated list of signs.

  ## Examples

      iex> list_signs(1)
      [%Sign{}, ...]
  """
  def list_signs(page) do
    Repo.paginate(
      from(s in Sign, order_by: [asc: s.id_gloss, asc: s.id]),
      %{page: page}
    )
  end

  @doc """
  Gets a single sign.

  Raises `Ecto.NoResultsError` if the Sign does not exist.

  ## Examples

      iex> get_sign!(123)
      %Sign{}

      iex> get_sign!(456)
      ** (Ecto.NoResultsError)

  """
  def get_sign!(id), do: Repo.get!(Sign, id)

  def get_sign_by_id_gloss!(id_gloss),
    do:
      Repo.get_by!(
        from(s in Sign,
          preload: [
            headsign: [],
            definitions: [],
            variants: [videos: [], regions: []],
            regions: [],
            videos: [],
            active_video: []
          ]
        ),
        id_gloss: id_gloss
      )

  def get_sign_by_keyword!(keyword),
    do:
      Repo.all(
        from(s in Sign,
          preload: [
            headsign: [],
            definitions: [],
            variants: [videos: [], regions: []],
            regions: [],
            videos: [],
            active_video: []
          ],
          where:
            fragment("?=any(lower(translations ::text)::text[])", ^keyword) and
              s.type == :headsign
        )
      )

  @doc """
  Either
  """
  def fuzzy_find_keyword(query) do
    case Repo.query(
           """
           select id_gloss, translation, levenshtein(s2.translation, $1) distance from
           (select unnest(signs.translations) as translation, id_gloss, "type" from signs
           where "type" = 'headsign') s2
           where levenshtein(translation, $1) < 3
           order by "distance" asc;
           """,
           [query]
         ) do
      {:ok, %Postgrex.Result{rows: rows}} ->
        case rows do
          [[id_gloss, keyword, 0] | _] ->
            {:ok, [[keyword, id_gloss]]}

          _ ->
            {:ok,
             rows
             |> Enum.map(fn r -> tl(Enum.reverse(r)) end)
             |> Enum.uniq_by(fn [kw, _] -> kw end)}
        end

      _ ->
        {:err, "No results found."}
    end
  end

  @doc """
  Creates a sign.

  ## Examples

      iex> create_sign(%{field: value})
      {:ok, %Sign{}}

      iex> create_sign(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_sign(attrs \\ %{}) do
    %Sign{}
    |> Sign.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a sign.

  ## Examples

      iex> update_sign(sign, %{field: new_value})
      {:ok, %Sign{}}

      iex> update_sign(sign, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_sign(%Sign{} = sign, attrs) do
    sign
    |> Sign.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a sign.

  ## Examples

      iex> delete_sign(sign)
      {:ok, %Sign{}}

      iex> delete_sign(sign)
      {:error, %Ecto.Changeset{}}

  """
  def delete_sign(%Sign{} = sign) do
    Repo.delete(sign)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking sign changes.

  ## Examples

      iex> change_sign(sign)
      %Ecto.Changeset{data: %Sign{}}

  """
  def change_sign(%Sign{} = sign, attrs \\ %{}) do
    Sign.changeset(sign, attrs)
  end
end
