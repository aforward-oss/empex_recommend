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
        gameplay_type: "some gameplay_type",
        top_rated: true
      })
      |> Gamedrop.Pos.create_gameplay()

    gameplay
  end

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
        top_rated: true
      })
      |> Gamedrop.Pos.create_gameplay()

    gameplay
  end

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
end
