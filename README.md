# empex_recommend

This repo provides supplementary documentation and code
for a [EMPEX 2023 Talk on Recommender Engines by Andrew Forward](https://www.empex.co/new-york#speakers)

The repo is comprised of three parts Livebook Notebooks, Pizzeria Sample App, Gamedrop Sample App

## Livebook Notebooks

The following are generic Livebooks around Elixir ML libraries

* [What are tensors?](/notebooks/tensors.livemd)
* [Predictions using Linear Regressions](/notebooks/linear_regressions.livemd)
* [Graphing Data Using VegaLite](/notebooks/vegalite.livemd)
* [Parametering Livebook using Kino](/notebooks/kino.livemd)

Next we have notebooks to support the code in the sample apps

* [Pizzeria Standalone](/notebooks/pizzeria.livemd)
* [Pizzeria App](/notebooks/pizzeria_app.livemd)
* [Gamedrop App](/notebooks/gamedrop_app.livemd)

To run the `Pizzera App` you will need to ensure the application is configured properly
and connected to Livebook using

```elixir
iex --sname pizzeria --cookie pizzeriacookie -S mix phx.server
```

To run the `Gamedrop App` you will need to ensure the application is configured properly
and connected to Livebook using

```elixir
iex --sname gamedrop --cookie gamedropcookie -S mix phx.server
```

These are internal notebooks used to generate screenshots and run
during the talk

* [The "livecoded" template for the talk](/notebooks/scratch.livemd)
* [The "livecoded" desired output for the talk](/notebooks/talk.livemd)
* [Screenshots for the talk](/notebooks/screenshots.livemd)

## Pizzeria

A web application to predict how many pizza doughs to prepare based on tonights reservations.
A quick start guide is here, but checkout [Pizzeria README](/pizzeria) for more information.

```bash
cd pizzeria
mix setup
mix run ./priv/repo/logarithmic.exs
iex --sname pizzeria --cookie pizzeriacookie -S mix phx.server
```

## Gamedrop

A web application for recommending video games based on your budget and gameplay type.
A quick start guide is here, but checkout [Gamedrop README](/gamedrop) for more information.

```bash
cd gamestart
mix setup
mix run ./priv/repo/seeds.exs
iex --sname gamedrop --cookie gamedropcookie -S mix phx.server
```
