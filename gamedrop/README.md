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

## Fly.io Deployment

Fly was intsalled with

```bash
flyctl launch
```

### Manage Secrets

To see these secrets run

```
flyctl secrets list
```

To add a new secret run

```
flyctl secrets set CLOAK_KEY=def456
```


### Deploy Application

After making changes you can deploy an updated version with.

```bash
flyctl deploy
```

### View Running Application

```bash
fly open
```

### Access Database

To analyze production data you can connect to postgres via

```bash
flyctl postgres connect -a gamedrop-db
```

### Debugging Production

You can [access the production iex shell](https://fly.io/docs/getting-started/elixir/#iex-shell-into-your-running-app).

```bash
# connect to the remote console
fly ssh console
```

And then attached to the running app

```bash
./bin/gamedrop remote
```


### Common Operations

Seed the gamedrop db

```elixir
Gamedrop.Migrations.Seeds.run()
```
