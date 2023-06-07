defmodule Gamedrop.Ml.PredictorTest do
  use ExUnit.Case, async: true
  alias Gamedrop.Ml.Predictor, as: ML
  doctest Gamedrop.Ml.Predictor

  describe "predict/x" do
    test "based on stored model" do
      assert !is_nil(ML.predict(%{"budget" => 1}))
    end

    test "grab the top N prediction" do
      top = ML.predict(%{"budget" => 1}, 5)
      assert !is_nil(top)
      assert Enum.count(top) == 5
    end
  end
end
