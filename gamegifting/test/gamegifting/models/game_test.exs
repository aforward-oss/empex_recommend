defmodule Gamegifting.Models.GameTest do
  use Gamegifting.DataCase, async: true
  alias Gamegifting.Models.Game
  doctest Gamegifting.Models.Game

  describe "upsert/1" do
    test "create if new" do
      Game.upsert(%{
        name: "Flappybirds",
        system_name: "WooES",
        date_released: ~D[2023-05-08],
        genre: "FPS",
        difficulty: 4,
        rating: 8
      })

      p = Game.find("Flappybirds")

      assert p.name == "Flappybirds"
      assert p.system_name == "WooES"
      assert p.date_released == ~D[2023-05-08]
      assert p.genre == "FPS"
      assert p.difficulty == 4
      assert p.rating == 8
    end

    test "default values" do
      Game.upsert(%{name: "NES"})
      p = Game.find("NES")

      assert p.name == "NES"
      assert p.system_name == nil
      assert p.date_released == nil
      assert p.genre == nil
      assert p.difficulty == nil
      assert p.rating == nil
    end

    test "update if existing" do
      a =
        Game.upsert(%{
          name: "Flappybirds",
          system_name: "WooES",
          date_released: ~D[2023-05-08],
          genre: "FPS",
          difficulty: 3,
          rating: 7
        })

      same_a =
        Game.upsert(%{
          name: "Flappybirds",
          system_name: "SuperWooES",
          date_released: ~D[2023-05-07],
          genre: "2PS",
          difficulty: 4,
          rating: 8
        })

      lookup_a = Game.find("Flappybirds")

      assert lookup_a.name == "Flappybirds"
      assert lookup_a.system_name == "SuperWooES"
      assert lookup_a.date_released == ~D[2023-05-07]
      assert lookup_a.genre == "2PS"
      assert lookup_a.difficulty == 4
      assert lookup_a.rating == 8

      assert same_a.id == a.id
      assert lookup_a.id == a.id
    end
  end

  describe "all" do
    test "none" do
      assert [] == Game.all()
    end

    test "some" do
      Game.upsert(%{name: "WooBirds"})
      Game.upsert(%{name: "NooBirds"})
      assert ["NooBirds", "WooBirds"] == Game.all() |> Enum.map(fn t -> t.name end)
    end
  end
end
