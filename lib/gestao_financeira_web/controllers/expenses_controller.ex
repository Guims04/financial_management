defmodule GestaoFinanceiraWeb.ExpensesController do
  use GestaoFinanceiraWeb, :controller

  alias GestaoFinanceira.Transactions
  alias GestaoFinanceira.Transactions.Expenses

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

    expenses = Transactions.list_expenses(
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
    render(conn, :index, expenses_collection: expenses, month_names: month_names)
  end

  def new(conn, _params) do
    changeset = Transactions.change_expenses(%Expenses{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"expenses" => expenses_params}) do
    user_id = conn.assigns[:current_user].id
    case Transactions.create_expenses(expenses_params, user_id) do
      {:ok, expenses} ->
        conn
        |> put_flash(:info, "Expenses created successfully.")
        |> redirect(to: ~p"/expenses/#{expenses}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    expenses = Transactions.get_expenses!(id)
    render(conn, :show, expenses: expenses)
  end

  def edit(conn, %{"id" => id}) do
    expenses = Transactions.get_expenses!(id)
    changeset = Transactions.change_expenses(expenses)
    render(conn, :edit, expenses: expenses, changeset: changeset)
  end

  def update(conn, %{"id" => id, "expenses" => expenses_params}) do
    expenses = Transactions.get_expenses!(id)

    case Transactions.update_expenses(expenses, expenses_params) do
      {:ok, expenses} ->
        conn
        |> put_flash(:info, "Expenses updated successfully.")
        |> redirect(to: ~p"/expenses/#{expenses}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, expenses: expenses, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    expenses = Transactions.get_expenses!(id)
    {:ok, _expenses} = Transactions.delete_expenses(expenses)

    conn
    |> put_flash(:info, "Expenses deleted successfully.")
    |> redirect(to: ~p"/expenses")
  end
end
