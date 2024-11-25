defmodule GestaoFinanceira.TransactionsFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `GestaoFinanceira.Transactions` context.
  """

  @doc """
  Generate a incomes.
  """
  def incomes_fixture(attrs \\ %{}) do
    {:ok, incomes} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        category: "some category",
        date: ~D[2024-11-12],
        description: "some description"
      })
      |> GestaoFinanceira.Transactions.create_incomes()

    incomes
  end

  @doc """
  Generate a expenses.
  """
  def expenses_fixture(attrs \\ %{}) do
    {:ok, expenses} =
      attrs
      |> Enum.into(%{
        amount: "120.5",
        category: "some category",
        date: ~D[2024-11-14],
        description: "some description"
      })
      |> GestaoFinanceira.Transactions.create_expenses()

    expenses
  end
end
