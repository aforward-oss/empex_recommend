# Pizzeria


## Setup

You can build a new application with

```
mix setup
```

A small dataset for the EMPEX web application

```
mix run ./priv/repo/seeds.exs
```

A larger dataset based on a `2x + 5` linear regression

```
mix run ./priv/repo/seeds.exs
```

## Livebook

To run with `./notebooks/pizzeria_app.livemd`, start with
the following cookie value

```
iex --sname pizzeria --cookie pizzeriacookie -S mix phx.server
```
