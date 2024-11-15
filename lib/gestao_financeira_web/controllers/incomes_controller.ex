defmodule GestaoFinanceiraWeb.IncomesController do
  use GestaoFinanceiraWeb, :controller

  alias GestaoFinanceira.Transactions
  alias GestaoFinanceira.Transactions.Incomes

  def index(conn, params) do
    user_id = conn.assigns[:current_user].id

    # Verificando se as datas são válidas
    start_date =
      case params["start_date"] do
        nil -> nil
        "" -> nil
        date_str -> Date.from_iso8601(date_str)
      end

    end_date =
      case params["end_date"] do
        nil -> nil
        "" -> nil
        date_str -> Date.from_iso8601(date_str)
      end

    # Aplicando o filtro
    filter = params["filter"]
    month = params["month"]

    incomes = Transactions.list_incomes(
      user_id,
      start_date,
      end_date,
      filter,
      month
    )

    month_names = %{
      1 => "Janeiro", 2 => "Fevereiro", 3 => "Março", 4 => "Abril",
      5 => "Maio", 6 => "Junho", 7 => "Julho", 8 => "Agosto",
      9 => "Setembro", 10 => "Outubro", 11 => "Novembro", 12 => "Dezembro"
    }

    render(conn, :index, incomes_collection: incomes, month_names: month_names)
  end

  def new(conn, _params) do
    changeset = Transactions.change_incomes(%Incomes{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"incomes" => incomes_params}) do
    user_id = conn.assigns[:current_user].id
    case Transactions.create_incomes(incomes_params, user_id) do
      {:ok, incomes} ->
        conn
        |> put_flash(:info, "Incomes created successfully.")
        |> redirect(to: ~p"/incomes/#{incomes}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    incomes = Transactions.get_incomes!(id)
    render(conn, :show, incomes: incomes)
  end

  def edit(conn, %{"id" => id}) do
    incomes = Transactions.get_incomes!(id)
    changeset = Transactions.change_incomes(incomes)
    render(conn, :edit, incomes: incomes, changeset: changeset)
  end

  def update(conn, %{"id" => id, "incomes" => incomes_params}) do
    incomes = Transactions.get_incomes!(id)

    case Transactions.update_incomes(incomes, incomes_params) do
      {:ok, incomes} ->
        conn
        |> put_flash(:info, "Incomes updated successfully.")
        |> redirect(to: ~p"/incomes/#{incomes}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, incomes: incomes, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    incomes = Transactions.get_incomes!(id)
    {:ok, _incomes} = Transactions.delete_incomes(incomes)

    conn
    |> put_flash(:info, "Incomes deleted successfully.")
    |> redirect(to: ~p"/incomes")
  end
end
