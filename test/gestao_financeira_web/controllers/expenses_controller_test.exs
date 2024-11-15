defmodule GestaoFinanceiraWeb.ExpensesControllerTest do
  use GestaoFinanceiraWeb.ConnCase

  import GestaoFinanceira.TransactionsFixtures

  @create_attrs %{date: ~D[2024-11-14], description: "some description", category: "some category", amount: "120.5"}
  @update_attrs %{date: ~D[2024-11-15], description: "some updated description", category: "some updated category", amount: "456.7"}
  @invalid_attrs %{date: nil, description: nil, category: nil, amount: nil}

  describe "index" do
    test "lists all expenses", %{conn: conn} do
      conn = get(conn, ~p"/expenses")
      assert html_response(conn, 200) =~ "Listing Expenses"
    end
  end

  describe "new expenses" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/expenses/new")
      assert html_response(conn, 200) =~ "New Expenses"
    end
  end

  describe "create expenses" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/expenses", expenses: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/expenses/#{id}"

      conn = get(conn, ~p"/expenses/#{id}")
      assert html_response(conn, 200) =~ "Expenses #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/expenses", expenses: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Expenses"
    end
  end

  describe "edit expenses" do
    setup [:create_expenses]

    test "renders form for editing chosen expenses", %{conn: conn, expenses: expenses} do
      conn = get(conn, ~p"/expenses/#{expenses}/edit")
      assert html_response(conn, 200) =~ "Edit Expenses"
    end
  end

  describe "update expenses" do
    setup [:create_expenses]

    test "redirects when data is valid", %{conn: conn, expenses: expenses} do
      conn = put(conn, ~p"/expenses/#{expenses}", expenses: @update_attrs)
      assert redirected_to(conn) == ~p"/expenses/#{expenses}"

      conn = get(conn, ~p"/expenses/#{expenses}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, expenses: expenses} do
      conn = put(conn, ~p"/expenses/#{expenses}", expenses: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Expenses"
    end
  end

  describe "delete expenses" do
    setup [:create_expenses]

    test "deletes chosen expenses", %{conn: conn, expenses: expenses} do
      conn = delete(conn, ~p"/expenses/#{expenses}")
      assert redirected_to(conn) == ~p"/expenses"

      assert_error_sent 404, fn ->
        get(conn, ~p"/expenses/#{expenses}")
      end
    end
  end

  defp create_expenses(_) do
    expenses = expenses_fixture()
    %{expenses: expenses}
  end
end
