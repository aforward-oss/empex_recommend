defmodule Pizzeria.Ml.PredictorTest do
  use Pizzeria.DataCase, async: true
  alias Pizzeria.Ml.Predictor, as: ML
  alias Pizzeria.Pos.{Order, Reservation}

  doctest Pizzeria.Ml.Predictor

  describe "train/0 and predict/2" do
    test "based on products" do
      Repo.insert!(%Order{
        item_name: "pizza",
        ordered_at: ~N[2023-09-21 10:11:12],
        quantity: 1,
        table_num: 1
      })

      Repo.insert!(%Reservation{
        name: "James",
        guests: 2,
        datetime: ~N[2023-09-21 10:11:12]
      })

      model = ML.train()

      assert ML.predict(2, model) == 1.0
    end
  end
end
