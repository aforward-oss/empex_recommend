# Gamedrop

## Setup

You can build a new application with

```
mix setup
```

A small dataset for the EMPEX web application

```
mix run ./priv/repo/seeds.exs
```

## Livebook

To run with `./notebooks/gamedrop_app.livemd` (for example), start with
the following cookie value

```
iex --sname gamedrop --cookie gamedropcookie -S mix phx.server
```
