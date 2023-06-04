defmodule Gamedrop.Ml.EngineTest do
  use Gamedrop.DataCase, async: true
  alias Gamedrop.Ml.Engine
  alias Gamedrop.Ml.Predictor, as: ML
  alias Gamedrop.Repo
  alias Gamedrop.Pos.Gameplay
  doctest Gamedrop.Ml.Engine

  describe "train/0 and predict/2 predict/3" do
    test "based on products" do
      Repo.insert!(%Gameplay{
        game_name: "frogger",
        gameplay_types: ["action"],
        rental_cost: Decimal.new("2.99"),
        top_rated: true
      })

      Repo.insert!(%Gameplay{
        game_name: "zelda",
        gameplay_types: ["action"],
        rental_cost: Decimal.new("59.99"),
        top_rated: true
      })

      {model, opts} = Engine.train()

      assert Keyword.keys(opts) == [
               :all_budgets,
               :all_game_types,
               :all_game_names
             ]

      assert ML.predict(%{budget: 1}, {model, opts}) == "frogger"
      assert ML.predict(%{budget: 3}, {model, opts}) == "zelda"

      assert ML.predict(%{"budget" => 1}, {model, opts}) == "frogger"
      assert ML.predict(%{"budget" => 3}, {model, opts}) == "zelda"
    end
  end
end
