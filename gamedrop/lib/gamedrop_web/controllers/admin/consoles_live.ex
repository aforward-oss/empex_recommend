defmodule GamedropWeb.AdminConsolesLive do
  use GamedropWeb, :live_view
  alias Gamedrop.Models.Console

  def mount(_params, _session, socket) do
    socket
    |> assign(:consoles, Console.all())
    |> reply(:ok)
  end

  def handle_event("upsert", params, socket) do
    Console.upsert(params)

    socket
    |> assign(:consoles, Console.all())
    |> reply(:noreply)
  end

  def render(assigns) do
    ~H"""
    <div class="flex min-h-full flex-col justify-center py-12 sm:px-6 lg:px-8">
      <div class="mt-8 sm:mx-auto sm:w-full sm:max-w-4xl">
        <div class="bg-white py-8 px-4 shadow sm:rounded-lg sm:px-10">
          <h1 class="text-xl font-bold mb-2">Consoles</h1>
          <div class="my-2">
            <%= for console <- @consoles ++ [%Console{id: "new"}] do %>
              <div class="inline-block min-w-full pb-2 align-middle">
                <table class="min-w-full">
                  <tbody>
                    <tr>
                      <td class="text-sm font-medium text-gray-900">
                        <.form for={nil} phx-submit="upsert" class="pt-1">
                          <div class="grid grid-cols-4 gap-4">
                            <div>
                              <label for={"console_console_name_#{console.id}"} class="sr-only">
                                Console Name
                              </label>
                              <input
                                type="text"
                                name="console_name"
                                id={"console_console_name_#{console.id}"}
                                value={console.console_name}
                                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                                placeholder="What is the name of the console"
                              />
                            </div>
                            <div>
                              <label for={"console_company_name_#{console.id}"} class="sr-only">
                                Company Name
                              </label>
                              <input
                                type="text"
                                name="company_name"
                                id={"console_company_name_#{console.id}"}
                                value={console.company_name}
                                class="block w-full rounded-md border-0 py-1.5 text-gray-900 shadow-sm ring-1 ring-inset ring-gray-300 placeholder:text-gray-400 focus:ring-2 focus:ring-inset focus:ring-indigo-600 sm:text-sm sm:leading-6"
                                placeholder="What is the name of the console"
                              />
                            </div>

                            <div>
                              <label for={"console_release_date_#{console.id}"} class="sr-only">
                                Release Date
                              </label>
                              <input
                                type="text"
                                name="release_date"
                                id={"console_release_date_#{console.id}"}
                                value={console.release_date}
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
                                <%= if console.id == "new", do: "Add", else: "Update" %>
                              </button>
                              <a
                                href={~p"/a/games/#{console.id}"}
                                class="mt-0.5 rounded py-1.5 px-2.5 sm:text-sm font-semibold underline shadow-sm focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500"
                              >
                                games
                              </a>
                            </div>
                          </div>
                          <input name="oldname" value={console.console_name} type="hidden" />
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
