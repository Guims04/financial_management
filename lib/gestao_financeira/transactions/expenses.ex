defmodule GestaoFinanceira.Transactions.Expenses do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expenses" do
    field :date, :date
    field :description, :string
    field :category, :string
    field :amount, :decimal

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(expenses, attrs) do
    expenses
    |> cast(attrs, [:amount, :description, :date, :category])
    |> validate_required([:amount, :description, :date, :category])
  end
end
