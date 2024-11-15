defmodule GestaoFinanceiraWeb.IncomesController do
  use GestaoFinanceiraWeb, :controller

  alias GestaoFinanceira.Transactions
  alias GestaoFinanceira.Transactions.Incomes

  def index(conn, _params) do
    user_id = conn.assigns[:current_user].id
    incomes = Transactions.list_incomes(user_id)
    render(conn, :index, incomes_collection: incomes)
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
