defmodule GestaoFinanceiraWeb.IncomesControllerTest do
  use GestaoFinanceiraWeb.ConnCase

  import GestaoFinanceira.TransactionsFixtures

  @create_attrs %{date: ~D[2024-11-12], description: "some description", category: "some category", amount: "120.5"}
  @update_attrs %{date: ~D[2024-11-13], description: "some updated description", category: "some updated category", amount: "456.7"}
  @invalid_attrs %{date: nil, description: nil, category: nil, amount: nil}

  describe "index" do
    test "lists all incomes", %{conn: conn} do
      conn = get(conn, ~p"/incomes")
      assert html_response(conn, 200) =~ "Listing Incomes"
    end
  end

  describe "new incomes" do
    test "renders form", %{conn: conn} do
      conn = get(conn, ~p"/incomes/new")
      assert html_response(conn, 200) =~ "New Incomes"
    end
  end

  describe "create incomes" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/incomes", incomes: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == ~p"/incomes/#{id}"

      conn = get(conn, ~p"/incomes/#{id}")
      assert html_response(conn, 200) =~ "Incomes #{id}"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/incomes", incomes: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Incomes"
    end
  end

  describe "edit incomes" do
    setup [:create_incomes]

    test "renders form for editing chosen incomes", %{conn: conn, incomes: incomes} do
      conn = get(conn, ~p"/incomes/#{incomes}/edit")
      assert html_response(conn, 200) =~ "Edit Incomes"
    end
  end

  describe "update incomes" do
    setup [:create_incomes]

    test "redirects when data is valid", %{conn: conn, incomes: incomes} do
      conn = put(conn, ~p"/incomes/#{incomes}", incomes: @update_attrs)
      assert redirected_to(conn) == ~p"/incomes/#{incomes}"

      conn = get(conn, ~p"/incomes/#{incomes}")
      assert html_response(conn, 200) =~ "some updated description"
    end

    test "renders errors when data is invalid", %{conn: conn, incomes: incomes} do
      conn = put(conn, ~p"/incomes/#{incomes}", incomes: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Incomes"
    end
  end

  describe "delete incomes" do
    setup [:create_incomes]

    test "deletes chosen incomes", %{conn: conn, incomes: incomes} do
      conn = delete(conn, ~p"/incomes/#{incomes}")
      assert redirected_to(conn) == ~p"/incomes"

      assert_error_sent 404, fn ->
        get(conn, ~p"/incomes/#{incomes}")
      end
    end
  end

  defp create_incomes(_) do
    incomes = incomes_fixture()
    %{incomes: incomes}
  end
end
