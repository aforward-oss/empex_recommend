defmodule Gamegifting.Migrations.Seed do
  alias Gamegifting.Models.{GamingPlatform, Game}

  def run() do
    Gamegifting.Repo.delete_all(GamingPlatform)
    Gamegifting.Repo.delete_all(Game)

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

    [
      %{
        name: "Pitfall!",
        system_name: "Atari 2600",
        date_released: ~D[1982-04-20],
        genre: "Platform",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Space Invaders",
        system_name: "Atari 2600",
        date_released: ~D[1980-03-31],
        genre: "Shoot 'em up",
        difficulty: 2,
        rating: 8
      },
      %{
        name: "Asteroids",
        system_name: "Atari 2600",
        date_released: ~D[1981-03-01],
        genre: "Shoot 'em up",
        difficulty: 3,
        rating: 8
      },
      %{
        name: "Missile Command",
        system_name: "Atari 2600",
        date_released: ~D[1981-07-01],
        genre: "Shoot 'em up",
        difficulty: 3,
        rating: 8
      },
      %{
        name: "Adventure",
        system_name: "Atari 2600",
        date_released: ~D[1980-03-01],
        genre: "Action-adventure",
        difficulty: 2,
        rating: 7
      },
      %{
        name: "Yars' Revenge",
        system_name: "Atari 2600",
        date_released: ~D[1981-05-01],
        genre: "Shoot 'em up",
        difficulty: 4,
        rating: 8
      },
      %{
        name: "Frogger",
        system_name: "Atari 2600",
        date_released: ~D[1981-10-23],
        genre: "Arcade",
        difficulty: 2,
        rating: 7
      },
      %{
        name: "Pac-Man",
        system_name: "Atari 2600",
        date_released: ~D[1982-04-01],
        genre: "Arcade",
        difficulty: 2,
        rating: 6
      },
      %{
        name: "Demon Attack",
        system_name: "Atari 2600",
        date_released: ~D[1982-03-01],
        genre: "Shoot 'em up",
        difficulty: 3,
        rating: 7
      },
      %{
        name: "River Raid",
        system_name: "Atari 2600",
        date_released: ~D[1982-11-01],
        genre: "Shoot 'em up",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "E.T. the Extra-Terrestrial",
        system_name: "Atari 2600",
        date_released: ~D[1982-12-01],
        genre: "Adventure",
        difficulty: 3,
        rating: 2
      },
      %{
        name: "Pac-Man",
        system_name: "Atari 2600",
        date_released: ~D[1982-04-01],
        genre: "Arcade",
        difficulty: 2,
        rating: 3
      },
      %{
        name: "Custer's Revenge",
        system_name: "Atari 2600",
        date_released: ~D[1982-09-23],
        genre: "Action",
        difficulty: 1,
        rating: 1
      },
      %{
        name: "Swordquest: Waterworld",
        system_name: "Atari 2600",
        date_released: ~D[1983-01-01],
        genre: "Action-adventure",
        difficulty: 4,
        rating: 3
      },
      %{
        name: "Chase the Chuckwagon",
        system_name: "Atari 2600",
        date_released: ~D[1983-01-01],
        genre: "Maze",
        difficulty: 2,
        rating: 2
      },
      %{
        name: "Karate",
        system_name: "Atari 2600",
        date_released: ~D[1982-01-01],
        genre: "Fighting",
        difficulty: 2,
        rating: 2
      },
      %{
        name: "Sneak 'n Peek",
        system_name: "Atari 2600",
        date_released: ~D[1982-01-01],
        genre: "Hide-and-seek",
        difficulty: 1,
        rating: 2
      },
      %{
        name: "Universal Chaos",
        system_name: "Atari 2600",
        date_released: ~D[1983-01-01],
        genre: "Shoot 'em up",
        difficulty: 3,
        rating: 2
      },
      %{
        name: "Beat 'Em & Eat 'Em",
        system_name: "Atari 2600",
        date_released: ~D[1982-10-13],
        genre: "Action",
        difficulty: 1,
        rating: 1
      },
      %{
        name: "Desert Falcon",
        system_name: "Atari 2600",
        date_released: ~D[1987-01-01],
        genre: "Shoot 'em up",
        difficulty: 3,
        rating: 3
      },
      %{
        name: "Super Mario Bros. 3",
        system_name: "NES",
        date_released: ~D[1988-10-23],
        genre: "Platform",
        difficulty: 3,
        rating: 10
      },
      %{
        name: "The Legend of Zelda",
        system_name: "NES",
        date_released: ~D[1986-02-21],
        genre: "Action-adventure",
        difficulty: 4,
        rating: 10
      },
      %{
        name: "Mega Man 2",
        system_name: "NES",
        date_released: ~D[1988-12-24],
        genre: "Action",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Metroid",
        system_name: "NES",
        date_released: ~D[1986-08-06],
        genre: "Action-adventure",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Castlevania",
        system_name: "NES",
        date_released: ~D[1986-09-26],
        genre: "Action",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Contra",
        system_name: "NES",
        date_released: ~D[1987-02-20],
        genre: "Run and gun",
        difficulty: 5,
        rating: 9
      },
      %{
        name: "Final Fantasy",
        system_name: "NES",
        date_released: ~D[1987-12-18],
        genre: "Role-playing",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Mike Tyson's Punch-Out!!",
        system_name: "NES",
        date_released: ~D[1987-11-21],
        genre: "Sports",
        difficulty: 4,
        rating: 8
      },
      %{
        name: "Dragon Warrior",
        system_name: "NES",
        date_released: ~D[1986-05-27],
        genre: "Role-playing",
        difficulty: 3,
        rating: 8
      },
      %{
        name: "Kirby's Adventure",
        system_name: "NES",
        date_released: ~D[1993-03-23],
        genre: "Platform",
        difficulty: 2,
        rating: 8
      },
      %{
        name: "Dr. Jekyll and Mr. Hyde",
        system_name: "NES",
        date_released: ~D[1988-04-08],
        genre: "Action",
        difficulty: 5,
        rating: 1
      },
      %{
        name: "Friday the 13th",
        system_name: "NES",
        date_released: ~D[1989-02-01],
        genre: "Survival horror",
        difficulty: 4,
        rating: 2
      },
      %{
        name: "Super Pitfall",
        system_name: "NES",
        date_released: ~D[1987-09-05],
        genre: "Platform",
        difficulty: 5,
        rating: 1
      },
      %{
        name: "X-Men",
        system_name: "NES",
        date_released: ~D[1989-12-01],
        genre: "Action",
        difficulty: 5,
        rating: 2
      },
      %{
        name: "Action 52",
        system_name: "NES",
        date_released: ~D[1991-01-01],
        genre: "Multicart",
        difficulty: 4,
        rating: 1
      },
      %{
        name: "Back to the Future",
        system_name: "NES",
        date_released: ~D[1989-09-01],
        genre: "Action-adventure",
        difficulty: 4,
        rating: 2
      },
      %{
        name: "The Uncanny X-Men",
        system_name: "NES",
        date_released: ~D[1989-12-01],
        genre: "Action",
        difficulty: 5,
        rating: 1
      },
      %{
        name: "Karate Champ",
        system_name: "NES",
        date_released: ~D[1986-01-01],
        genre: "Fighting",
        difficulty: 3,
        rating: 2
      },
      %{
        name: "Where's Waldo?",
        system_name: "NES",
        date_released: ~D[1991-09-01],
        genre: "Puzzle",
        difficulty: 2,
        rating: 1
      },
      %{
        name: "Shaq Fu",
        system_name: "NES",
        date_released: ~D[1994-10-28],
        genre: "Fighting",
        difficulty: 4,
        rating: 2
      },
      %{
        name: "The Legend of Zelda: A Link to the Past",
        system_name: "SNES",
        date_released: ~D[1991-11-21],
        genre: "Action-adventure",
        difficulty: 3,
        rating: 10
      },
      %{
        name: "Super Metroid",
        system_name: "SNES",
        date_released: ~D[1994-03-19],
        genre: "Action-adventure",
        difficulty: 4,
        rating: 10
      },
      %{
        name: "Chrono Trigger",
        system_name: "SNES",
        date_released: ~D[1995-03-11],
        genre: "Role-playing",
        difficulty: 3,
        rating: 10
      },
      %{
        name: "Super Mario World",
        system_name: "SNES",
        date_released: ~D[1990-11-21],
        genre: "Platform",
        difficulty: 2,
        rating: 10
      },
      %{
        name: "Final Fantasy VI",
        system_name: "SNES",
        date_released: ~D[1994-04-02],
        genre: "Role-playing",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "EarthBound",
        system_name: "SNES",
        date_released: ~D[1994-08-27],
        genre: "Role-playing",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Secret of Mana",
        system_name: "SNES",
        date_released: ~D[1993-08-06],
        genre: "Action role-playing",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Mega Man X",
        system_name: "SNES",
        date_released: ~D[1993-12-17],
        genre: "Action",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Super Mario Kart",
        system_name: "SNES",
        date_released: ~D[1992-08-27],
        genre: "Racing",
        difficulty: 2,
        rating: 9
      },
      %{
        name: "Donkey Kong Country",
        system_name: "SNES",
        date_released: ~D[1994-11-21],
        genre: "Platform",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Rise of the Robots",
        system_name: "SNES",
        date_released: ~D[1994-11-01],
        genre: "Fighting",
        difficulty: 3,
        rating: 1
      },
      %{
        name: "Shaq Fu",
        system_name: "SNES",
        date_released: ~D[1994-10-28],
        genre: "Fighting",
        difficulty: 4,
        rating: 2
      },
      %{
        name: "Bubsy in Claws Encounters of the Furred Kind",
        system_name: "SNES",
        date_released: ~D[1993-05-01],
        genre: "Platform",
        difficulty: 4,
        rating: 2
      },
      %{
        name: "Pit Fighter",
        system_name: "SNES",
        date_released: ~D[1992-09-01],
        genre: "Fighting",
        difficulty: 3,
        rating: 1
      },
      %{
        name: "Captain Novolin",
        system_name: "SNES",
        date_released: ~D[1992-11-01],
        genre: "Platform",
        difficulty: 2,
        rating: 1
      },
      %{
        name: "Super 3D Noah's Ark",
        system_name: "SNES",
        date_released: ~D[1994-01-01],
        genre: "First-person shooter",
        difficulty: 3,
        rating: 2
      },
      %{
        name: "Rex Ronan: Experimental Surgeon",
        system_name: "SNES",
        date_released: ~D[1993-01-01],
        genre: "Action",
        difficulty: 3,
        rating: 1
      },
      %{
        name: "Lester the Unlikely",
        system_name: "SNES",
        date_released: ~D[1994-01-01],
        genre: "Platform",
        difficulty: 4,
        rating: 1
      },
      %{
        name: "Dragon's Lair",
        system_name: "SNES",
        date_released: ~D[1992-04-01],
        genre: "Interactive movie",
        difficulty: 5,
        rating: 2
      },
      %{
        name: "Street Hockey '95",
        system_name: "SNES",
        date_released: ~D[1994-01-01],
        genre: "Sports",
        difficulty: 2,
        rating: 1
      },
      %{
        name: "Sonic the Hedgehog 2",
        system_name: "Sega Genesis",
        date_released: ~D[1992-11-21],
        genre: "Platform",
        difficulty: 3,
        rating: 10
      },
      %{
        name: "Streets of Rage 2",
        system_name: "Sega Genesis",
        date_released: ~D[1992-12-20],
        genre: "Beat 'em up",
        difficulty: 4,
        rating: 10
      },
      %{
        name: "Gunstar Heroes",
        system_name: "Sega Genesis",
        date_released: ~D[1993-09-10],
        genre: "Run and gun",
        difficulty: 4,
        rating: 10
      },
      %{
        name: "Shining Force II",
        system_name: "Sega Genesis",
        date_released: ~D[1993-10-01],
        genre: "Tactical role-playing",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Phantasy Star IV: The End of the Millennium",
        system_name: "Sega Genesis",
        date_released: ~D[1993-12-17],
        genre: "Role-playing",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Castlevania: Bloodlines",
        system_name: "Sega Genesis",
        date_released: ~D[1994-03-18],
        genre: "Platform",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Contra: Hard Corps",
        system_name: "Sega Genesis",
        date_released: ~D[1994-08-08],
        genre: "Run and gun",
        difficulty: 5,
        rating: 9
      },
      %{
        name: "Sonic the Hedgehog",
        system_name: "Sega Genesis",
        date_released: ~D[1991-06-23],
        genre: "Platform",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Earthworm Jim",
        system_name: "Sega Genesis",
        date_released: ~D[1994-08-02],
        genre: "Platform",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Vectorman",
        system_name: "Sega Genesis",
        date_released: ~D[1995-10-24],
        genre: "Run and gun",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Dark Castle",
        system_name: "Sega Genesis",
        date_released: ~D[1991-01-01],
        genre: "Platform",
        difficulty: 5,
        rating: 1
      },
      %{
        name: "Shaq Fu",
        system_name: "Sega Genesis",
        date_released: ~D[1994-10-28],
        genre: "Fighting",
        difficulty: 4,
        rating: 2
      },
      %{
        name: "Superman",
        system_name: "Sega Genesis",
        date_released: ~D[1992-10-01],
        genre: "Action",
        difficulty: 5,
        rating: 1
      },
      %{
        name: "Slaughter Sport",
        system_name: "Sega Genesis",
        date_released: ~D[1991-01-01],
        genre: "Fighting",
        difficulty: 4,
        rating: 1
      },
      %{
        name: "Time Killers",
        system_name: "Sega Genesis",
        date_released: ~D[1996-12-31],
        genre: "Fighting",
        difficulty: 3,
        rating: 2
      },
      %{
        name: "Bubsy in Claws Encounters of the Furred Kind",
        system_name: "Sega Genesis",
        date_released: ~D[1993-05-01],
        genre: "Platform",
        difficulty: 4,
        rating: 2
      },
      %{
        name: "Bebe's Kids",
        system_name: "Sega Genesis",
        date_released: ~D[1994-01-01],
        genre: "Beat 'em up",
        difficulty: 3,
        rating: 1
      },
      %{
        name: "The Incredible Crash Dummies",
        system_name: "Sega Genesis",
        date_released: ~D[1993-07-01],
        genre: "Platform",
        difficulty: 3,
        rating: 1
      },
      %{
        name: "Rise of the Robots",
        system_name: "Sega Genesis",
        date_released: ~D[1994-11-01],
        genre: "Fighting",
        difficulty: 3,
        rating: 1
      },
      %{
        name: "Chester Cheetah: Wild Wild Quest",
        system_name: "Sega Genesis",
        date_released: ~D[1993-01-01],
        genre: "Platform",
        difficulty: 2,
        rating: 2
      },
      %{
        name: "The Legend of Zelda: Link's Awakening",
        system_name: "Game Boy",
        date_released: ~D[1993-06-06],
        genre: "Action-adventure",
        difficulty: 3,
        rating: 10
      },
      %{
        name: "Pokémon Red and Blue",
        system_name: "Game Boy",
        date_released: ~D[1998-09-28],
        genre: "Role-playing",
        difficulty: 2,
        rating: 10
      },
      %{
        name: "Tetris",
        system_name: "Game Boy",
        date_released: ~D[1989-06-14],
        genre: "Puzzle",
        difficulty: 3,
        rating: 10
      },
      %{
        name: "Super Mario Land 2: 6 Golden Coins",
        system_name: "Game Boy",
        date_released: ~D[1992-11-02],
        genre: "Platform",
        difficulty: 2,
        rating: 9
      },
      %{
        name: "Wario Land: Super Mario Land 3",
        system_name: "Game Boy",
        date_released: ~D[1994-02-01],
        genre: "Platform",
        difficulty: 2,
        rating: 9
      },
      %{
        name: "Kirby's Dream Land",
        system_name: "Game Boy",
        date_released: ~D[1992-08-01],
        genre: "Platform",
        difficulty: 1,
        rating: 9
      },
      %{
        name: "Donkey Kong",
        system_name: "Game Boy",
        date_released: ~D[1994-06-01],
        genre: "Platform",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Metroid II: Return of Samus",
        system_name: "Game Boy",
        date_released: ~D[1991-11-01],
        genre: "Action-adventure",
        difficulty: 4,
        rating: 8
      },
      %{
        name: "Mega Man V",
        system_name: "Game Boy",
        date_released: ~D[1994-09-01],
        genre: "Action",
        difficulty: 4,
        rating: 8
      },
      %{
        name: "Final Fantasy Adventure",
        system_name: "Game Boy",
        date_released: ~D[1991-12-01],
        genre: "Action role-playing",
        difficulty: 3,
        rating: 8
      },
      %{
        name: "Carmageddon",
        system_name: "Game Boy",
        date_released: ~D[1999-12-01],
        genre: "Racing",
        difficulty: 3,
        rating: 1
      },
      %{
        name: "The Tick",
        system_name: "Game Boy",
        date_released: ~D[1994-01-01],
        genre: "Action",
        difficulty: 4,
        rating: 1
      },
      %{
        name: "Barbie: Game Girl",
        system_name: "Game Boy",
        date_released: ~D[1992-01-01],
        genre: "Platform",
        difficulty: 2,
        rating: 2
      },
      %{
        name: "Captain Planet and the Planeteers",
        system_name: "Game Boy",
        date_released: ~D[1991-01-01],
        genre: "Action",
        difficulty: 4,
        rating: 1
      },
      %{
        name: "Mortal Kombat 3",
        system_name: "Game Boy",
        date_released: ~D[1995-12-31],
        genre: "Fighting",
        difficulty: 4,
        rating: 2
      },
      %{
        name: "Home Alone",
        system_name: "Game Boy",
        date_released: ~D[1991-12-01],
        genre: "Action",
        difficulty: 3,
        rating: 1
      },
      %{
        name: "Total Recall",
        system_name: "Game Boy",
        date_released: ~D[1991-07-01],
        genre: "Action",
        difficulty: 5,
        rating: 2
      },
      %{
        name: "Wayne's World",
        system_name: "Game Boy",
        date_released: ~D[1993-01-01],
        genre: "Platform",
        difficulty: 3,
        rating: 1
      },
      %{
        name: "Jeopardy! Platinum Edition",
        system_name: "Game Boy",
        date_released: ~D[1993-01-01],
        genre: "Trivia",
        difficulty: 2,
        rating: 2
      },
      %{
        name: "The Flintstones: King Rock Treasure Island",
        system_name: "Game Boy",
        date_released: ~D[1993-01-01],
        genre: "Platform",
        difficulty: 3,
        rating: 2
      },
      %{
        name: "Final Fantasy VII",
        system_name: "PSOne",
        date_released: ~D[1997-09-07],
        genre: "Role-playing",
        difficulty: 3,
        rating: 10
      },
      %{
        name: "Metal Gear Solid",
        system_name: "PSOne",
        date_released: ~D[1998-10-21],
        genre: "Stealth action",
        difficulty: 4,
        rating: 10
      },
      %{
        name: "Castlevania: Symphony of the Night",
        system_name: "PSOne",
        date_released: ~D[1997-10-02],
        genre: "Action-adventure",
        difficulty: 4,
        rating: 10
      },
      %{
        name: "Resident Evil 2",
        system_name: "PSOne",
        date_released: ~D[1998-01-21],
        genre: "Survival horror",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Gran Turismo 2",
        system_name: "PSOne",
        date_released: ~D[1999-12-11],
        genre: "Racing simulation",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Silent Hill",
        system_name: "PSOne",
        date_released: ~D[1999-02-23],
        genre: "Survival horror",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Tekken 3",
        system_name: "PSOne",
        date_released: ~D[1998-03-26],
        genre: "Fighting",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Crash Bandicoot: Warped",
        system_name: "PSOne",
        date_released: ~D[1998-10-31],
        genre: "Platform",
        difficulty: 2,
        rating: 9
      },
      %{
        name: "Spyro the Dragon",
        system_name: "PSOne",
        date_released: ~D[1998-09-10],
        genre: "Platform",
        difficulty: 2,
        rating: 9
      },
      %{
        name: "Tony Hawk's Pro Skater 2",
        system_name: "PSOne",
        date_released: ~D[2000-09-20],
        genre: "Sports",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Bubsy 3D",
        system_name: "PSOne",
        date_released: ~D[1996-10-31],
        genre: "Platform",
        difficulty: 4,
        rating: 1
      },
      %{
        name: "Superman",
        system_name: "PSOne",
        date_released: ~D[1999-07-31],
        genre: "Action",
        difficulty: 5,
        rating: 1
      },
      %{
        name: "Street Fighter: The Movie",
        system_name: "PSOne",
        date_released: ~D[1995-08-01],
        genre: "Fighting",
        difficulty: 3,
        rating: 2
      },
      %{
        name: "Mortal Kombat: Special Forces",
        system_name: "PSOne",
        date_released: ~D[2000-07-30],
        genre: "Action-adventure",
        difficulty: 4,
        rating: 2
      },
      %{
        name: "Shaq Fu: A Legend Reborn",
        system_name: "PSOne",
        date_released: ~D[1994-10-28],
        genre: "Fighting",
        difficulty: 4,
        rating: 2
      },
      %{
        name: "Dragon Ball GT: Final Bout",
        system_name: "PSOne",
        date_released: ~D[1997-07-31],
        genre: "Fighting",
        difficulty: 3,
        rating: 2
      },
      %{
        name: "Rise 2: Resurrection",
        system_name: "PSOne",
        date_released: ~D[1996-06-01],
        genre: "Fighting",
        difficulty: 3,
        rating: 1
      },
      %{
        name: "The Crow: City of Angels",
        system_name: "PSOne",
        date_released: ~D[1997-10-31],
        genre: "Action-adventure",
        difficulty: 5,
        rating: 1
      },
      %{
        name: "Casper: Friends Around the World",
        system_name: "PSOne",
        date_released: ~D[2000-11-20],
        genre: "Adventure",
        difficulty: 2,
        rating: 1
      },
      %{
        name: "Rascal",
        system_name: "PSOne",
        date_released: ~D[1998-03-31],
        genre: "Platform",
        difficulty: 4,
        rating: 2
      },
      %{
        name: "The Legend of Zelda: Ocarina of Time",
        system_name: "Nintendo 64",
        date_released: ~D[1998-11-21],
        genre: "Action-adventure",
        difficulty: 3,
        rating: 10
      },
      %{
        name: "Super Mario 64",
        system_name: "Nintendo 64",
        date_released: ~D[1996-06-23],
        genre: "Platform",
        difficulty: 3,
        rating: 10
      },
      %{
        name: "GoldenEye 007",
        system_name: "Nintendo 64",
        date_released: ~D[1997-08-25],
        genre: "First-person shooter",
        difficulty: 4,
        rating: 10
      },
      %{
        name: "Banjo-Kazooie",
        system_name: "Nintendo 64",
        date_released: ~D[1998-06-29],
        genre: "Platform",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Mario Kart 64",
        system_name: "Nintendo 64",
        date_released: ~D[1996-12-14],
        genre: "Racing",
        difficulty: 2,
        rating: 9
      },
      %{
        name: "The Legend of Zelda: Majora's Mask",
        system_name: "Nintendo 64",
        date_released: ~D[2000-04-27],
        genre: "Action-adventure",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Perfect Dark",
        system_name: "Nintendo 64",
        date_released: ~D[2000-05-22],
        genre: "First-person shooter",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Star Fox 64",
        system_name: "Nintendo 64",
        date_released: ~D[1997-04-27],
        genre: "Rail shooter",
        difficulty: 3,
        rating: 9
      },
      %{
        name: "Conker's Bad Fur Day",
        system_name: "Nintendo 64",
        date_released: ~D[2001-03-05],
        genre: "Action-adventure",
        difficulty: 4,
        rating: 9
      },
      %{
        name: "Paper Mario",
        system_name: "Nintendo 64",
        date_released: ~D[2000-08-11],
        genre: "Role-playing",
        difficulty: 2,
        rating: 9
      }
    ]
    |> Enum.each(&Game.upsert/1)
  end
end
