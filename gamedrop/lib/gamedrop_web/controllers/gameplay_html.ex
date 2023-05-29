defmodule GamedropWeb.GameplayHTML do
  use GamedropWeb, :html

  embed_templates "gameplay_html/*"

  @doc """
  Renders a gameplay form.
  """
  attr :changeset, Ecto.Changeset, required: true
  attr :action, :string, required: true

  def gameplay_form(assigns)
end
