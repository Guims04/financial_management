defmodule GestaoFinanceira.TransactionsTest do
  use GestaoFinanceira.DataCase

  alias GestaoFinanceira.Transactions

  describe "incomes" do
    alias GestaoFinanceira.Transactions.Incomes

    import GestaoFinanceira.TransactionsFixtures

    @invalid_attrs %{date: nil, description: nil, category: nil, amount: nil}

    test "list_incomes/0 returns all incomes" do
      incomes = incomes_fixture()
      assert Transactions.list_incomes() == [incomes]
    end

    test "get_incomes!/1 returns the incomes with given id" do
      incomes = incomes_fixture()
      assert Transactions.get_incomes!(incomes.id) == incomes
    end

    test "create_incomes/1 with valid data creates a incomes" do
      valid_attrs = %{date: ~D[2024-11-12], description: "some description", category: "some category", amount: "120.5"}

      assert {:ok, %Incomes{} = incomes} = Transactions.create_incomes(valid_attrs)
      assert incomes.date == ~D[2024-11-12]
      assert incomes.description == "some description"
      assert incomes.category == "some category"
      assert incomes.amount == Decimal.new("120.5")
    end

    test "create_incomes/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_incomes(@invalid_attrs)
    end

    test "update_incomes/2 with valid data updates the incomes" do
      incomes = incomes_fixture()
      update_attrs = %{date: ~D[2024-11-13], description: "some updated description", category: "some updated category", amount: "456.7"}

      assert {:ok, %Incomes{} = incomes} = Transactions.update_incomes(incomes, update_attrs)
      assert incomes.date == ~D[2024-11-13]
      assert incomes.description == "some updated description"
      assert incomes.category == "some updated category"
      assert incomes.amount == Decimal.new("456.7")
    end

    test "update_incomes/2 with invalid data returns error changeset" do
      incomes = incomes_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_incomes(incomes, @invalid_attrs)
      assert incomes == Transactions.get_incomes!(incomes.id)
    end

    test "delete_incomes/1 deletes the incomes" do
      incomes = incomes_fixture()
      assert {:ok, %Incomes{}} = Transactions.delete_incomes(incomes)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_incomes!(incomes.id) end
    end

    test "change_incomes/1 returns a incomes changeset" do
      incomes = incomes_fixture()
      assert %Ecto.Changeset{} = Transactions.change_incomes(incomes)
    end
  end

  describe "expenses" do
    alias GestaoFinanceira.Transactions.Expenses

    import GestaoFinanceira.TransactionsFixtures

    @invalid_attrs %{date: nil, description: nil, category: nil, amount: nil}

    test "list_expenses/0 returns all expenses" do
      expenses = expenses_fixture()
      assert Transactions.list_expenses() == [expenses]
    end

    test "get_expenses!/1 returns the expenses with given id" do
      expenses = expenses_fixture()
      assert Transactions.get_expenses!(expenses.id) == expenses
    end

    test "create_expenses/1 with valid data creates a expenses" do
      valid_attrs = %{date: ~D[2024-11-14], description: "some description", category: "some category", amount: "120.5"}

      assert {:ok, %Expenses{} = expenses} = Transactions.create_expenses(valid_attrs)
      assert expenses.date == ~D[2024-11-14]
      assert expenses.description == "some description"
      assert expenses.category == "some category"
      assert expenses.amount == Decimal.new("120.5")
    end

    test "create_expenses/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transactions.create_expenses(@invalid_attrs)
    end

    test "update_expenses/2 with valid data updates the expenses" do
      expenses = expenses_fixture()
      update_attrs = %{date: ~D[2024-11-15], description: "some updated description", category: "some updated category", amount: "456.7"}

      assert {:ok, %Expenses{} = expenses} = Transactions.update_expenses(expenses, update_attrs)
      assert expenses.date == ~D[2024-11-15]
      assert expenses.description == "some updated description"
      assert expenses.category == "some updated category"
      assert expenses.amount == Decimal.new("456.7")
    end

    test "update_expenses/2 with invalid data returns error changeset" do
      expenses = expenses_fixture()
      assert {:error, %Ecto.Changeset{}} = Transactions.update_expenses(expenses, @invalid_attrs)
      assert expenses == Transactions.get_expenses!(expenses.id)
    end

    test "delete_expenses/1 deletes the expenses" do
      expenses = expenses_fixture()
      assert {:ok, %Expenses{}} = Transactions.delete_expenses(expenses)
      assert_raise Ecto.NoResultsError, fn -> Transactions.get_expenses!(expenses.id) end
    end

    test "change_expenses/1 returns a expenses changeset" do
      expenses = expenses_fixture()
      assert %Ecto.Changeset{} = Transactions.change_expenses(expenses)
    end
  end
end
