defmodule GamedropWeb.GameIdeaLive do
  use GamedropWeb, :live_view
  alias Gamedrop.Ml.Worker
  alias Gamedrop.Pos.Game

  @impl true
  def mount(_params, _session, socket) do
    ml_opts = Worker.opts()

    socket
    |> assign(:all_game_types, ml_opts[:all_game_types])
    |> assign_game(nil)
    |> assign(:step, :input)
    |> reply(:ok)
  end

  @impl true
  def render(assigns) do
    case assigns[:step] do
      :input ->
        render_form(assigns)

      :calculating ->
        render_calculating(assigns)

      :suggestion ->
        render_suggestion(assigns)
    end
  end

  def render_form(assigns) do
    ~H"""
    <body class={"#{assigns[:css_body_class] || "bg-white antialiased"}"}>
      <div class="bg-white">
        <div class="relative">
          <div class="mx-auto max-w-7xl">
            <div class="relative z-10 pt-14 lg:w-full lg:max-w-2xl lg:h-screen">
              <svg
                class="absolute inset-y-0 right-8 hidden h-full w-80 translate-x-1/2 transform fill-white lg:block"
                viewBox="0 0 100 100"
                preserveAspectRatio="none"
                aria-hidden="true"
              >
                <polygon points="0,0 90,0 50,100 0,100" />
              </svg>

              <div class="relative px-6 py-32 sm:py-40 lg:px-8 lg:py-56 lg:pr-0">
                <div class="mx-auto max-w-2xl lg:mx-0 lg:max-w-xl">
                  <h1 class="text-4xl font-bold tracking-tight text-gray-900 sm:text-6xl">
                    Gamedrop Tavern
                  </h1>
                  <p class="mt-6 text-lg leading-8 text-gray-600">
                    Come play any game, any console by yourself, with your family, or with friends.  Let's help you pick your game.
                  </p>
                  <div class="mt-10 gap-x-6">
                    <.form for={nil} phx-submit="suggest" class="pt-1">
                      <div class="grid grid-cols-1 gap-4">
                        <div>
                          <label for="budget" class="sr-only">Budget</label>
                          <select
                            name="budget"
                            id="budget"
                            class="w-full"
                            placeholder="Select your game pricing preference."
                          >
                            <option value="1">budget-friendly</option>
                            <option value="2">standard</option>
                            <option value="3">premium</option>
                          </select>
                        </div>
                        <div>
                          <label for="game_types" class="sr-only">
                            Game types
                          </label>
                          <select
                            name="game_types[]"
                            id="game_types"
                            class="w-full"
                            placeholder="What kind of game are you looking for?"
                            multiple
                          >
                            <%= for g <- @all_game_types do %>
                              <option value={g}><%= g %></option>
                            <% end %>
                          </select>
                        </div>
                        <div>
                          <button
                            type="submit"
                            class="mt-0.5 rounded bg-indigo-500 py-1.5 px-2.5 sm:text-sm font-semibold text-white shadow-sm hover:bg-indigo-400 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-indigo-500"
                          >
                            Show me which game
                          </button>
                        </div>
                      </div>
                    </.form>
                  </div>
                </div>
              </div>
            </div>
          </div>
          <div class="bg-gray-50 lg:absolute lg:inset-y-0 lg:right-0 lg:w-1/2">
            <img
              class="h-full w-full lg:aspect-[3/2] object-cover lg:aspect-auto lg:h-full lg:w-full"
              src="/images/console_mural.png"
              alt=""
            />
          </div>
        </div>
      </div>
    </body>
    """
  end

  def render_calculating(assigns) do
    ~H"""
    <body class="bg-white antialiased">
      <div class="mx-auto max-w-2xl py-32 sm:py-40 lg:pb-56 lg:pr-0">
        <div class="flex justify-center items-center sm:mb-10">
          <p class="text-left text-xl">Inspired by</p>
          <img class="h-11 ml-2" src={~p"/images/logo.png"} alt="GiftBetter logo" />
        </div>
        <h1 class="mt-10 font-bold text-center tracking-tight text-gray-900 text-4xl">
          Gamedrop Tavern
        </h1>

        <p class="mt-10 text-2xl sm:text-4xl text-center text-gray-900">
          Hang tight... we’re scouring our vast video game collection to find the perfect game for you
        </p>
      </div>
    </body>
    """
  end

  def render_suggestion(assigns) do
    ~H"""
    <body class="bg-white antialiased">
      <div class="relative isolate overflow-hidden bg-white">
        <div class="mx-auto md:flex md:items-center max-w-7xl px-6 pb-24 pt-10 sm:pb-32 lg:flex lg:px-8 lg:py-32">
          <div class="mx-auto max-w-2xl px-8 lg:mx-0 lg:max-w-xl lg:flex-shrink-0">
            <h1 class="text-4xl font-bold tracking-tight text-gray-900 ">
              <%= @game %>
            </h1>
            <p class="mt-6 text-lg leading-8 text-gray-600">
              <a href="https://giftbetter.co">Gift Better Co.</a>
              makes it effortless for teams to customize gifts for clients, prospects, employees, or special projects.
            </p>
            <div class="mt-6 grid grid-1">
              <button
                phx-click="change_criteria"
                class="w-full px-3.5 py-2.5 underline text-base text-center font-semibold text-gray-400 hover:text-violet-500 focus-visible:outline focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-violet-600"
              >
                Change my criteria
              </button>
            </div>
          </div>
          <div class="mx-auto mt-10 lg:mt-0 grid grid-1 justify-center items-center">
            <img src={game_image_src(@game)} class="drop-shadow-2xl rounded-2xl" />
            <p class="text-center"><%= @game %></p>
          </div>
        </div>
      </div>
    </body>
    """
  end

  @impl true
  def handle_event("suggest", params, socket) do
    view_pid = self()

    spawn(fn ->
      Gamedrop.calculating_sleep()

      params
      |> clean()
      |> Worker.predict()
      |> then(&send(view_pid, {:calculation_done, &1}))
    end)

    socket
    |> assign(:step, :calculating)
    |> reply(:noreply)
  end

  @impl true
  def handle_event("change_criteria", params, socket) do
    socket
    |> assign_game(nil)
    |> assign(:step, :input)
    |> reply(:noreply)
  end

  @impl true
  def handle_info({:calculation_done, game}, socket) do
    socket
    |> assign(:step, :suggestion)
    |> assign_game(game)
    |> reply(:noreply)
  end

  def clean(features) do
    budget =
      features
      |> Map.get("budget", "1")
      |> Integer.parse()
      |> case do
        :error -> 1
        {found, ""} -> found
      end

    %{
      budget: budget,
      game_types: Map.get(features, "game_types", [])
    }
  end

  def game_image_src(game_name) do
    "/images/games/#{Game.slug(%{game_name: game_name})}.jpg"
  end

  def assign_game(socket, game) do
    socket
    |> assign(:game, game)
  end

  defp reply(socket, ok), do: {ok, socket}
end
