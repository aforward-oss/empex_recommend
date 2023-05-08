defmodule Gamegifting.Models.GamingPlatformTest do
  use Gamegifting.DataCase, async: true
  alias Gamegifting.Models.GamingPlatform
  doctest Gamegifting.Models.GamingPlatform

  describe "upsert/1" do
    test "create if new" do
      GamingPlatform.upsert(%{
        company_name: "Woo",
        system_name: "WooES",
        date_released: ~D[2023-05-08],
        company_website: "https://woo.local"
      })

      p = GamingPlatform.find("WooES")

      assert p.company_name == "Woo"
      assert p.system_name == "WooES"
      assert p.date_released == ~D[2023-05-08]
      assert p.company_website == "https://woo.local"
    end

    test "default values" do
      GamingPlatform.upsert(%{system_name: "NES"})
      p = GamingPlatform.find("NES")

      assert p.company_name == nil
      assert p.system_name == "NES"
      assert p.date_released == nil
      assert p.company_website == nil
    end

    test "update if existing" do
      a =
        GamingPlatform.upsert(%{
          company_name: "Woo",
          system_name: "WooES",
          date_released: ~D[2023-05-08],
          company_website: "https://woo.local"
        })

      same_a =
        GamingPlatform.upsert(%{
          company_name: "Woo Inc",
          system_name: "WooES",
          date_released: ~D[2023-05-07],
          company_website: "https://wooinc.local"
        })

      lookup_a = GamingPlatform.find("WooES")

      assert lookup_a.company_name == "Woo Inc"
      assert lookup_a.system_name == "WooES"
      assert lookup_a.date_released == ~D[2023-05-07]
      assert lookup_a.company_website == "https://wooinc.local"

      assert same_a.id == a.id
      assert lookup_a.id == a.id
    end
  end

  describe "all" do
    test "none" do
      assert [] == GamingPlatform.all()
    end

    test "some" do
      GamingPlatform.upsert(%{system_name: "WooES"})
      GamingPlatform.upsert(%{system_name: "NES"})
      assert ["NES", "WooES"] == GamingPlatform.all() |> Enum.map(fn t -> t.system_name end)
    end
  end
end
