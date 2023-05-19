defmodule GamedropWeb.AdminGamesLive do
  use GamedropWeb, :live_view
  alias Gamedrop.Models.{Console, Game}

  def mount(%{"console_id" => console_id}, _session, socket) do
    console = Console.by_id(console_id)

    socket
    |> assign(:css_body_class, "bg-white md:bg-slate-800")
    |> assign(:console, console)
    |> assign(:games, Game.all_for_console(console))
    |> reply(:ok)
  end

  def handle_event("upsert", params, socket) do
    Game.upsert(params)

    socket
    |> assign(:games, Game.all())
    |> reply(:noreply)
  end

  def render(assigns) do
    ~H"""
    <div class="flex min-h-full flex-col justify-center py-12 sm:px-6 lg:px-8">
      <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-4xl">
        <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
          <h1 class="text-xl font-bold mb-2">Consoles</h1>
          <div class="my-2">
            <%= for game <- @games ++ [%Game{id: "new"}] do %>
              <div class="inline-block min-w-full pb-2 align-middle">
                <table class="min-w-full">
                  <tbody>
                    <tr>
                      <td class="text-sm font-medium text-gray-900">
                        <.form for={nil} phx-submit="upsert" class="pt-1">
                          <div class="grid grid-cols-4 gap-4">
                            <div>
                              <label for={"game_game_name_#{game.id}"} class="sr-only">
                                Game Name
                              </label>
                              <input
                                type="text"
                                name="game_name"
                                id={"game_game_name_#{game.id}"}
                                value={game.game_name}
                                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                                placeholder="What is the name of the console"
                              />
                            </div>
                            <div>
                              <label for={"game_console_name_#{game.id}"} class="sr-only">
                                Console Name
                              </label>
                              <input
                                type="text"
                                name="console_name"
                                id={"game_console_name_#{game.id}"}
                                value={game.console_name}
                                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                                placeholder="What is the name of the console"
                              />
                            </div>

                            <div>
                              <label for={"game_release_date_#{game.id}"} class="sr-only">
                                Release Date
                              </label>
                              <input
                                type="text"
                                name="release_date"
                                id={"game_release_date_#{game.id}"}
                                value={game.release_date}
                                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                                placeholder="When was the console released?"
                              />
                            </div>
                            <div>
                              <button
                                type="submit"
                                phx-disable-with="..."
                                class="mt-0.5 rounded bg-indigo-500 py-1.5 px-2.5 sm:text-sm font-semibold text-white shadow-sm hover:bg-indigo-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500"
                              >
                                <%= if game.id == "new", do: "Add", else: "Update" %>
                              </button>
                            </div>
                          </div>
                          <input name="oldname" value={game.console_name} type="hidden" />
                        </.form>
                      </td>
                    </tr>
                  </tbody>
                </table>
              </div>
            <% end %>
          </div>
        </div>
      </div>
    </div>
    """
  end

  defp reply(socket, ok), do: {ok, socket}
end
