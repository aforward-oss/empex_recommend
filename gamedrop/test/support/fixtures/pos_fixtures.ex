defmodule Gamedrop.PosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Gamedrop.Pos` context.
  """

  @doc """
  Generate a gameplay.
  """
  def gameplay_fixture(attrs \\ %{}) do
    {:ok, gameplay} =
      attrs
      |> Enum.into(%{
        console_name: "some console_name",
        game_name: "some game_name",
        gameplay_types: ["option1", "option2"],
        rental_cost: "120.5",
        top_rated: true
      })
      |> Gamedrop.Pos.create_gameplay()

    gameplay
  end

  @doc """
  Generate a console.
  """
  def console_fixture(attrs \\ %{}) do
    {:ok, console} =
      attrs
      |> Enum.into(%{
        company_name: "some company_name",
        company_website: "some company_website",
        console_name: "some console_name",
        release_date: ~D[2023-05-28]
      })
      |> Gamedrop.Pos.create_console()

    console
  end

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        console_name: "some console_name",
        description: "some description",
        developer: "some developer",
        difficulty: 42,
        game_name: "some game_name",
        gameplay_rating: 42,
        genre: "some genre",
        maturity_rating: "some maturity_rating",
        multiplayer: true,
        player_mode: "some player_mode",
        release_date: ~D[2023-05-28]
      })
      |> Gamedrop.Pos.create_game()

    game
  end
end
