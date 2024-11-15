defmodule GestaoFinanceiraWeb.ExpensesHTML do
  use GestaoFinanceiraWeb, :html

  embed_templates "expenses_html/*"

  @doc """
  Renders a expenses form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def expenses_form(assigns)
end
