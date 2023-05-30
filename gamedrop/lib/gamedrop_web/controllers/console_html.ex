defmodule GamedropWeb.ConsoleHTML do
  use GamedropWeb, :html

  embed_templates "console_html/*"

  @doc """
  Renders a console form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def console_form(assigns)
end
