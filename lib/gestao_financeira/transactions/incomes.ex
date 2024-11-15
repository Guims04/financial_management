defmodule GestaoFinanceira.Transactions.Incomes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "incomes" do
    field :date, :date
    field :description, :string
    field :category, :string
    field :amount, :decimal

    # Relacionamentos
    belongs_to :user, GestaoFinanceira.Accounts.User

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(incomes, attrs) do
    incomes
    |> cast(attrs, [:amount, :description, :date, :category, :user_id])
    |> validate_required([:amount, :description, :date, :category, :user_id])
  end
end
