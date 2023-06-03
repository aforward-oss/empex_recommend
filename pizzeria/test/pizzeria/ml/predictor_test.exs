defmodule Pizzeria.Ml.PredictorTest do
  use Pizzeria.DataCase, async: true
  alias Pizzeria.Ml.Predictor, as: ML
  doctest Pizzeria.Ml.Predictor

  describe "predict/1" do
    test "based on stored model" do
      assert !is_nil(ML.predict(2))
    end
  end
end
