defmodule GestaoFinanceira.Transactions do
  @moduledoc """
  The Transactions context.
  """

  import Ecto.Query, warn: false
  alias GestaoFinanceira.Repo

  alias GestaoFinanceira.Transactions.Incomes

  @doc """
  Returns the list of incomes.

  ## Examples

      iex> list_incomes()
      [%Incomes{}, ...]

  """
  def list_incomes(user_id) do
    Repo.all(from i in Incomes, where: i.user_id == ^user_id)
  end

  @doc """
  Gets a single incomes.

  Raises `Ecto.NoResultsError` if the Incomes does not exist.

  ## Examples

      iex> get_incomes!(123)
      %Incomes{}

      iex> get_incomes!(456)
      ** (Ecto.NoResultsError)

  """
  def get_incomes!(id), do: Repo.get!(Incomes, id)

  @doc """
  Creates a incomes.

  ## Examples

      iex> create_incomes(%{field: value})
      {:ok, %Incomes{}}

      iex> create_incomes(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_incomes(attrs \\ %{}, user_id) do
    %Incomes{}
    |> Incomes.changeset(Map.put(attrs, "user_id", user_id))
    |> Repo.insert()
  end

  @doc """
  Updates a incomes.

  ## Examples

      iex> update_incomes(incomes, %{field: new_value})
      {:ok, %Incomes{}}

      iex> update_incomes(incomes, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_incomes(%Incomes{} = incomes, attrs) do
    incomes
    |> Incomes.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a incomes.

  ## Examples

      iex> delete_incomes(incomes)
      {:ok, %Incomes{}}

      iex> delete_incomes(incomes)
      {:error, %Ecto.Changeset{}}

  """
  def delete_incomes(%Incomes{} = incomes) do
    Repo.delete(incomes)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking incomes changes.

  ## Examples

      iex> change_incomes(incomes)
      %Ecto.Changeset{data: %Incomes{}}

  """
  def change_incomes(%Incomes{} = incomes, attrs \\ %{}) do
    Incomes.changeset(incomes, attrs)
  end
end
