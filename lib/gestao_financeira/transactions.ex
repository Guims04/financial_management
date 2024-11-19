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
  def list_incomes(user_id, start_date, end_date, filter, month) do
    query = from i in Incomes,
            where: i.user_id == ^user_id

    query =
      case start_date do
        nil -> query
        "" -> query
        _ ->
          start_date = elem(start_date, 1)
          from q in query, where: q.date >= ^start_date
      end

    # Aplicando filtro para a data de fim
    query =
      case end_date do
        nil -> query
        "" -> query
        _ ->
          end_date = elem(end_date, 1)
          from q in query, where: q.date <= ^end_date
      end

    # Aplicando filtro para a categoria (se fornecido)
    query =
      case filter do
        "lowest" -> from q in query, order_by: [asc: q.amount]  # Ordem crescente (menor para maior)
        "highest" -> from q in query, order_by: [desc: q.amount]  # Ordem decrescente (maior para menor)
        _ -> query
      end

    # Aplicando filtro para o mês (se fornecido)
    query =
      case month do
        "" -> query
        nil -> query
        _ ->
          # Garantir que o valor de month seja um inteiro
          month_int = String.to_integer(month)
          from q in query, where: fragment("date_part(?, ?)", "month", q.date) == ^month_int
      end

    # Executando a consulta
    Repo.all(query)
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

  alias GestaoFinanceira.Transactions.Expenses

  @doc """
  Returns the list of expenses.

  ## Examples

      iex> list_expenses()
      [%Expenses{}, ...]

  """
  def list_expenses(user_id, start_date, end_date, filter, month) do
    query = from i in Expenses,
            where: i.user_id == ^user_id

    query =
      case start_date do
        nil -> query
        "" -> query
        _ ->
          start_date = elem(start_date, 1)
          from q in query, where: q.date >= ^start_date
      end

    # Aplicando filtro para a data de fim
    query =
      case end_date do
        nil -> query
        "" -> query
        _ ->
          end_date = elem(end_date, 1)
          from q in query, where: q.date <= ^end_date
      end

    # Aplicando filtro para a categoria (se fornecido)
    query =
      case filter do
        "lowest" -> from q in query, order_by: [asc: q.amount]  # Ordem crescente (menor para maior)
        "highest" -> from q in query, order_by: [desc: q.amount]  # Ordem decrescente (maior para menor)
        _ -> query
      end

    # Aplicando filtro para o mês (se fornecido)
    query =
      case month do
        "" -> query
        nil -> query
        _ ->
          # Garantir que o valor de month seja um inteiro
          month_int = String.to_integer(month)
          from q in query, where: fragment("date_part(?, ?)", "month", q.date) == ^month_int
      end

    Repo.all(query)
  end

  @doc """
  Gets a single expenses.

  Raises `Ecto.NoResultsError` if the Expenses does not exist.

  ## Examples

      iex> get_expenses!(123)
      %Expenses{}

      iex> get_expenses!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expenses!(id), do: Repo.get!(Expenses, id)

  @doc """
  Creates a expenses.

  ## Examples

      iex> create_expenses(%{field: value})
      {:ok, %Expenses{}}

      iex> create_expenses(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expenses(attrs \\ %{}, user_id) do
    %Expenses{}
    |> Expenses.changeset(Map.put(attrs, "user_id", user_id))
    |> Repo.insert()
  end

  @doc """
  Updates a expenses.

  ## Examples

      iex> update_expenses(expenses, %{field: new_value})
      {:ok, %Expenses{}}

      iex> update_expenses(expenses, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expenses(%Expenses{} = expenses, attrs) do
    expenses
    |> Expenses.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expenses.

  ## Examples

      iex> delete_expenses(expenses)
      {:ok, %Expenses{}}

      iex> delete_expenses(expenses)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expenses(%Expenses{} = expenses) do
    Repo.delete(expenses)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expenses changes.

  ## Examples

      iex> change_expenses(expenses)
      %Ecto.Changeset{data: %Expenses{}}

  """
  def change_expenses(%Expenses{} = expenses, attrs \\ %{}) do
    Expenses.changeset(expenses, attrs)
  end
end
