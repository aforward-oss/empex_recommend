defmodule Gamedrop.Models.GameTest do
  use Gamedrop.DataCase, async: true
  alias Gamedrop.Models.Game
  doctest Gamedrop.Models.Game

  describe "upsert/1" do
    test "create if new" do
      Game.upsert(%{
        game_name: "Flappybirds",
        console_name: "WooES",
        release_date: ~D[2023-05-08],
        genre: "FPS",
        difficulty: 4,
        gameplay_rating: 8,
        developer: "FBirds",
        maturity_rating: "PG13",
        multiplayer: true,
        player_mode: "Single",
        description: "I love cheese"
      })

      p = Game.find("Flappybirds")

      assert p.game_name == "Flappybirds"
      assert p.console_name == "WooES"
      assert p.release_date == ~D[2023-05-08]
      assert p.genre == "FPS"
      assert p.difficulty == 4
      assert p.gameplay_rating == 8
      assert p.developer == "FBirds"
      assert p.maturity_rating == "PG13"
      assert p.multiplayer == true
      assert p.player_mode == "Single"
      assert p.description == "I love cheese"
    end

    test "default values" do
      Game.upsert(%{game_name: "NES"})
      p = Game.find("NES")

      assert p.game_name == "NES"
      assert p.console_name == nil
      assert p.release_date == nil
      assert p.genre == nil
      assert p.difficulty == nil
      assert p.gameplay_rating == nil
      assert p.developer == nil
      assert p.maturity_rating == nil
      assert p.multiplayer == nil
      assert p.player_mode == nil
      assert p.description == nil
    end

    test "update if existing" do
      a =
        Game.upsert(%{
          game_name: "Flappybirds",
          console_name: "WooES",
          release_date: ~D[2023-05-08],
          genre: "FPS",
          difficulty: 3,
          gameplay_rating: 7,
          developer: "XBirds",
          maturity_rating: "PG14",
          multiplayer: false,
          player_mode: "Multiple",
          description: "I love burgers"
        })

      same_a =
        Game.upsert(%{
          game_name: "Flappybirds",
          console_name: "SuperWooES",
          release_date: ~D[2023-05-07],
          genre: "2PS",
          difficulty: 4,
          gameplay_rating: 8,
          developer: "FBirds",
          maturity_rating: "PG13",
          multiplayer: true,
          player_mode: "Single",
          description: "I love cheese"
        })

      lookup_a = Game.find("Flappybirds")

      assert lookup_a.game_name == "Flappybirds"
      assert lookup_a.console_name == "SuperWooES"
      assert lookup_a.release_date == ~D[2023-05-07]
      assert lookup_a.genre == "2PS"
      assert lookup_a.difficulty == 4
      assert lookup_a.gameplay_rating == 8
      assert lookup_a.developer == "FBirds"
      assert lookup_a.maturity_rating == "PG13"
      assert lookup_a.multiplayer == true
      assert lookup_a.player_mode == "Single"
      assert lookup_a.description == "I love cheese"

      assert same_a.id == a.id
      assert lookup_a.id == a.id
    end
  end

  describe "all" do
    test "none" do
      assert [] == Game.all()
    end

    test "some" do
      Game.upsert(%{game_name: "WooBirds"})
      Game.upsert(%{game_name: "NooBirds"})
      assert ["NooBirds", "WooBirds"] == Game.all() |> Enum.map(fn t -> t.game_name end)
    end
  end
end
