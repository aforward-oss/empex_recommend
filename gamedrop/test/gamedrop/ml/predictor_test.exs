defmodule Gamedrop.Ml.PredictorTest do
  use ExUnit.Case, async: true
  alias Gamedrop.Ml.Predictor, as: ML
  doctest Gamedrop.Ml.Predictor

  describe "predict/1" do
    test "based on stored model" do
      assert !is_nil(ML.predict(%{"budget" => 1}))
    end
  end
end
