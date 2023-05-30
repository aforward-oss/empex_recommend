defmodule GamedropWeb.ConsoleController do
  use GamedropWeb, :controller

  alias Gamedrop.Pos
  alias Gamedrop.Pos.Console

  def index(conn, _params) do
    consoles = Pos.list_consoles()
    render(conn, :index, consoles: consoles)
  end

  def new(conn, _params) do
    changeset = Pos.change_console(%Console{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"console" => console_params}) do
    case Pos.create_console(console_params) do
      {:ok, console} ->
        conn
        |> put_flash(:info, "Console created successfully.")
        |> redirect(to: ~p"/consoles/#{console}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    console = Pos.get_console!(id)
    render(conn, :show, console: console)
  end

  def edit(conn, %{"id" => id}) do
    console = Pos.get_console!(id)
    changeset = Pos.change_console(console)
    render(conn, :edit, console: console, changeset: changeset)
  end

  def update(conn, %{"id" => id, "console" => console_params}) do
    console = Pos.get_console!(id)

    case Pos.update_console(console, console_params) do
      {:ok, console} ->
        conn
        |> put_flash(:info, "Console updated successfully.")
        |> redirect(to: ~p"/consoles/#{console}")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :edit, console: console, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    console = Pos.get_console!(id)
    {:ok, _console} = Pos.delete_console(console)

    conn
    |> put_flash(:info, "Console deleted successfully.")
    |> redirect(to: ~p"/consoles")
  end
end
