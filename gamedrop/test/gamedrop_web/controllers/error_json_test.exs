defmodule GamedropWeb.ErrorJSONTest do
  use GamedropWeb.ConnCase, async: true

  test "renders 404" do
    assert GamedropWeb.ErrorJSON.render("404.json", %{}) == %{errors: %{detail: "Not Found"}}
  end

  test "renders 500" do
    assert GamedropWeb.ErrorJSON.render("500.json", %{}) ==
             %{errors: %{detail: "Internal Server Error"}}
  end
end
