defmodule GestaoFinanceiraWeb.ExpensesController do
  use GestaoFinanceiraWeb, :controller

  alias GestaoFinanceira.Transactions
  alias GestaoFinanceira.Transactions.Expenses

  def index(conn, _params) do
    expenses = Transactions.list_expenses()
    render(conn, :index, expenses_collection: expenses)
  end

  def new(conn, _params) do
    changeset = Transactions.change_expenses(%Expenses{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"expenses" => expenses_params}) do
    case Transactions.create_expenses(expenses_params) do
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
