defmodule Gamedrop.Models.ConsoleTest do
  use Gamedrop.DataCase, async: true
  alias Gamedrop.Models.Console
  doctest Gamedrop.Models.Console

  describe "upsert/1" do
    test "create if new" do
      Console.upsert(%{
        company_name: "Woo",
        console_name: "WooES",
        release_date: ~D[2023-05-08],
        company_website: "https://woo.local"
      })

      p = Console.find("WooES")

      assert p.company_name == "Woo"
      assert p.console_name == "WooES"
      assert p.release_date == ~D[2023-05-08]
      assert p.company_website == "https://woo.local"
    end

    test "default values" do
      Console.upsert(%{console_name: "NES"})
      p = Console.find("NES")

      assert p.company_name == nil
      assert p.console_name == "NES"
      assert p.release_date == nil
      assert p.company_website == nil
    end

    test "update if existing" do
      a =
        Console.upsert(%{
          company_name: "Woo",
          console_name: "WooES",
          release_date: ~D[2023-05-08],
          company_website: "https://woo.local"
        })

      same_a =
        Console.upsert(%{
          company_name: "Woo Inc",
          console_name: "WooES",
          release_date: ~D[2023-05-07],
          company_website: "https://wooinc.local"
        })

      lookup_a = Console.find("WooES")

      assert lookup_a.company_name == "Woo Inc"
      assert lookup_a.console_name == "WooES"
      assert lookup_a.release_date == ~D[2023-05-07]
      assert lookup_a.company_website == "https://wooinc.local"

      assert same_a.id == a.id
      assert lookup_a.id == a.id
    end

    test "update string params" do
      a =
        Console.upsert(%{
          company_name: "Woo",
          console_name: "WooES",
          release_date: ~D[2023-05-08],
          company_website: "https://woo.local"
        })

      same_a =
        Console.upsert(%{
          "company_name" => "Woo Inc",
          "console_name" => "WooES",
          "release_date" => ~D[2023-05-07],
          "company_website" => "https://wooinc.local"
        })

      lookup_a = Console.find("WooES")

      assert lookup_a.company_name == "Woo Inc"
      assert lookup_a.console_name == "WooES"
      assert lookup_a.release_date == ~D[2023-05-07]
      assert lookup_a.company_website == "https://wooinc.local"

      assert same_a.id == a.id
      assert lookup_a.id == a.id
    end
  end

  describe "all" do
    test "none" do
      assert [] == Console.all()
    end

    test "some" do
      Console.upsert(%{console_name: "WooES"})
      Console.upsert(%{console_name: "NES"})
      assert ["NES", "WooES"] == Console.all() |> Enum.map(fn t -> t.console_name end)
    end
  end

  describe "by_id" do
    test "not found" do
      assert nil == Console.by_id(-1)
    end

    test "found" do
      c = Console.upsert(%{console_name: "WooES"})
      assert c == Console.by_id(c.id)
    end
  end
end
