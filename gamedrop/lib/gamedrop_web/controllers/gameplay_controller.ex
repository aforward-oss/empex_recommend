defmodule GamedropWeb.GameplayController do
  use GamedropWeb, :controller

  alias Gamedrop.Pos
  alias Gamedrop.Pos.Gameplay

  def index(conn, _params) do
    gameplays = Pos.list_gameplays()
    render(conn, :index, gameplays: gameplays)
  end

  def new(conn, _params) do
    changeset = Pos.change_gameplay(%Gameplay{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"gameplay" => gameplay_params}) do
    case Pos.create_gameplay(gameplay_params) do
      {:ok, gameplay} ->
        conn
        |> put_flash(:info, "Gameplay created successfully.")
        |> redirect(to: ~p"/gameplays/#{gameplay}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    gameplay = Pos.get_gameplay!(id)
    render(conn, :show, gameplay: gameplay)
  end

  def edit(conn, %{"id" => id}) do
    gameplay = Pos.get_gameplay!(id)
    changeset = Pos.change_gameplay(gameplay)
    render(conn, :edit, gameplay: gameplay, changeset: changeset)
  end

  def update(conn, %{"id" => id, "gameplay" => gameplay_params}) do
    gameplay = Pos.get_gameplay!(id)

    case Pos.update_gameplay(gameplay, gameplay_params) do
      {:ok, gameplay} ->
        conn
        |> put_flash(:info, "Gameplay updated successfully.")
        |> redirect(to: ~p"/gameplays/#{gameplay}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, gameplay: gameplay, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    gameplay = Pos.get_gameplay!(id)
    {:ok, _gameplay} = Pos.delete_gameplay(gameplay)

    conn
    |> put_flash(:info, "Gameplay deleted successfully.")
    |> redirect(to: ~p"/gameplays")
  end
end
