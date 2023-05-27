defmodule PizzeriaWeb.ReservationHTML do
  use PizzeriaWeb, :html

  embed_templates "reservation_html/*"

  @doc """
  Renders a reservation form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def reservation_form(assigns)
end
