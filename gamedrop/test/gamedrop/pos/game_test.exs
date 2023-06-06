defmodule Gamedrop.Pos.GameTest do
  use Gamedrop.DataCase

  alias Gamedrop.Pos.Game
  doctest Game

  describe "slug" do
    test "all the slugish things" do
      assert "ms-pac-man" == Game.slug(%Game{game_name: "Ms. Pac-Man"})

      assert "grand-theft-auto-san-andreas" ==
               Game.slug(%Game{game_name: "Grand Theft Auto: San Andreas"})
    end
  end
end
