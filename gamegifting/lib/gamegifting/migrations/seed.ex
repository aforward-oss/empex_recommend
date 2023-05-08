defmodule Gamegifting.Migrations.Seed do
  alias Gamegifting.Models.GamingPlatform

  def run() do
    Gamegifting.Repo.delete_all(GamingPlatform)

    [
      %{
        company_name: "Atari",
        system_name: "Atari 2600",
        date_released: ~D[1977-09-11],
        company_website: "https://www.atari.com/"
      },
      %{
        company_name: "Nintendo",
        system_name: "NES",
        date_released: ~D[1985-07-15],
        company_website: "https://www.nintendo.com/nes-classic/"
      },
      %{
        company_name: "Super Nintendo Entertainment System",
        system_name: "SNES",
        date_released: ~D[1990-11-21],
        company_website: "https://www.nintendo.com/super-nes-classic/"
      },
      %{
        company_name: "Sega",
        system_name: "Sega Genesis",
        date_released: ~D[1988-10-29],
        company_website: "https://www.sega.com/"
      },
      %{
        company_name: "Nintendo",
        system_name: "Game Boy",
        date_released: ~D[1989-04-21],
        company_website: "https://www.nintendo.com/game-boy/"
      },
      %{
        company_name: "Sony",
        system_name: "PSOne",
        date_released: ~D[1994-12-03],
        company_website: "https://www.playstation.com/en-us/"
      },
      %{
        company_name: "Nintendo",
        system_name: "Nintendo 64",
        date_released: ~D[1996-06-23],
        company_website: "https://www.nintendo.com/nintendo-64/"
      },
      %{
        company_name: "Sega",
        system_name: "Sega Dreamcast",
        date_released: ~D[1998-11-27],
        company_website: "https://www.sega.com/"
      },
      %{
        company_name: "Microsoft",
        system_name: "Xbox",
        date_released: ~D[2001-11-15],
        company_website: "https://www.xbox.com/"
      },
      %{
        company_name: "Nintendo",
        system_name: "GameCube",
        date_released: ~D[2001-11-18],
        company_website: "https://www.nintendo.com/gamecube/"
      },
      %{
        company_name: "Sony",
        system_name: "PS2",
        date_released: ~D[2000-03-04],
        company_website: "https://www.playstation.com/en-us/"
      },
      %{
        company_name: "Microsoft",
        system_name: "Xbox 360",
        date_released: ~D[2005-11-22],
        company_website: "https://www.xbox.com/xbox-360/"
      },
      %{
        company_name: "Nintendo",
        system_name: "Wii",
        date_released: ~D[2006-11-19],
        company_website: "https://www.nintendo.com/wii/"
      },
      %{
        company_name: "Sony",
        system_name: "PS3",
        date_released: ~D[2006-11-17],
        company_website: "https://www.playstation.com/en-us/"
      },
      %{
        company_name: "Nintendo",
        system_name: "Wii U",
        date_released: ~D[2012-11-18],
        company_website: "https://www.nintendo.com/wii-u/"
      },
      %{
        company_name: "Microsoft",
        system_name: "Xbox One",
        date_released: ~D[2013-11-22],
        company_website: "https://www.xbox.com/xbox-one/"
      },
      %{
        company_name: "Sony",
        system_name: "PS4",
        date_released: ~D[2013-11-15],
        company_website: "https://www.playstation.com/en-us/"
      },
      %{
        company_name: "Nintendo",
        system_name: "Nintendo Switch",
        date_released: ~D[2017-03-03],
        company_website: "https://www.nintendo.com/switch/"
      },
      %{
        company_name: "Sony",
        system_name: "PS5",
        date_released: ~D[2020-11-12],
        company_website: "https://www.playstation.com/en-us/ps5/"
      },
      %{
        company_name: "Sony",
        system_name: "PSP",
        date_released: ~D[2004-12-12],
        company_website: "https://www.playstation.com/en-us/psp/"
      },
      %{
        company_name: "Nintendo",
        system_name: "Nintendo DS",
        date_released: ~D[2004-11-21],
        company_website: "https://www.nintendo.com/ds/"
      },
      %{
        company_name: "Nintendo",
        system_name: "Nintendo 3DS",
        date_released: ~D[2011-03-27],
        company_website: "https://www.nintendo.com/3ds/"
      },
      %{
        company_name: "Microsoft",
        system_name: "Xbox Series S",
        date_released: ~D[2020-11-10],
        company_website: "https://www.xbox.com/en-US/consoles/xbox-series-s"
      },
      %{
        company_name: "Sony",
        system_name: "PlayStation VR",
        date_released: ~D[2016-10-13],
        company_website: "https://www.playstation.com/en-us/explore/playstation-vr/"
      },
      %{
        company_name: "Coleco",
        system_name: "ColecoVision",
        date_released: ~D[1982-08-01],
        company_website: "https://www.colecovisionzone.com/"
      }
    ]
    |> Enum.each(&GamingPlatform.upsert/1)
  end
end
