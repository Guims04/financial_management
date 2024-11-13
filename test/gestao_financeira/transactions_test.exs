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
end
