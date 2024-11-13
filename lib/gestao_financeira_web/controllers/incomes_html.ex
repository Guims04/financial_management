defmodule GestaoFinanceiraWeb.IncomesHTML do
  use GestaoFinanceiraWeb, :html

  embed_templates "incomes_html/*"

  @doc """
  Renders a incomes form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def incomes_form(assigns)
end
