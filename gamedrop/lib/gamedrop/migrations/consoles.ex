defmodule Gamedrop.Migrations.Consoles do
  alias Gamedrop.Repo

  def run() do
    consoles()
    atari_games()
    nes_games()
    :ok
  end

  def consoles() do
    Repo.delete_all(Gamedrop.Models.Console)

    Repo.run_sql("""
    INSERT INTO consoles
    (console_name, date_released, company_website, company_name, inserted_at, updated_at)
    VALUES
    ('Atari 2600', '1977-09-11', 'https://www.atari.com', 'Atari', NOW(), NOW()),
    ('ColecoVision', '1982-08-01', 'http://www.coleco.com/', 'Coleco', NOW(), NOW()),
    ('Game Boy', '1989-04-21', 'https://www.nintendo.com', 'Nintendo', NOW(), NOW()),
    ('GameCube', '2001-09-14', 'https://www.nintendo.com', 'Nintendo', NOW(), NOW()),
    ('NES', '1983-07-15', 'https://www.nintendo.com', 'Nintendo', NOW(), NOW()),
    ('Nintendo 3DS', '2011-02-26', 'https://www.nintendo.com', 'Nintendo', NOW(), NOW()),
    ('Nintendo 64', '1996-06-23', 'https://www.nintendo.com', 'Nintendo', NOW(), NOW()),
    ('Nintendo DS', '2004-11-21', 'https://www.nintendo.com', 'Nintendo', NOW(), NOW()),
    ('Wii U', '2012-11-18', 'https://www.nintendo.com', 'Nintendo', NOW(), NOW()),
    ('Wii', '2006-11-19', 'https://www.nintendo.com', 'Nintendo', NOW(), NOW()),
    ('Nintendo Switch', '2017-03-03', 'https://www.nintendo.com', 'Nintendo', NOW(), NOW()),
    ('PSOne', '2000-07-07', 'https://www.playstation.com', 'Sony', NOW(), NOW()),
    ('PS2', '2000-03-04', 'https://www.playstation.com', 'Sony', NOW(), NOW()),
    ('PS3', '2006-11-11', 'https://www.playstation.com', 'Sony', NOW(), NOW()),
    ('PS4', '2013-11-15', 'https://www.playstation.com', 'Sony', NOW(), NOW()),
    ('PS5', '2020-11-12', 'https://www.playstation.com', 'Sony', NOW(), NOW()),
    ('PSP', '2004-12-12', 'https://www.playstation.com', 'Sony', NOW(), NOW()),
    ('PlayStation VR', '2016-10-13', 'https://www.playstation.com', 'Sony', NOW(), NOW()),
    ('SNES', '1990-11-21', 'https://www.nintendo.com', 'Nintendo', NOW(), NOW()),
    ('Sega Dreamcast', '1998-11-27', 'https://www.sega.com', 'Sega', NOW(), NOW()),
    ('Sega Genesis', '1988-10-29', 'https://www.sega.com', 'Sega', NOW(), NOW()),
    ('Xbox 360', '2005-11-22', 'https://www.xbox.com', 'Microsoft', NOW(), NOW()),
    ('Xbox One', '2013-11-22', 'https://www.xbox.com', 'Microsoft', NOW(), NOW()),
    ('Xbox', '2001-11-15', 'https://www.xbox.com', 'Microsoft', NOW(), NOW());
    """)
  end

  def atari_games() do
    Repo.run_sql("DELETE FROM games WHERE console_name = 'Atari 2600'")

    Repo.run_sql("""
    INSERT INTO games
    (game_name, genre, console_name, release_date, developer, maturity_rating, gameplay_rating, multiplayer, player_mode, difficulty, description, inserted_at, updated_at)
    VALUES
    ('Adventure', 'Adventure', 'Atari 2600', '1980-06-01', 'Atari', 'E', 80, false, 'Single-player', 2, 'A graphical adventure game and one of the first console games to feature a playing area larger than one screen.', NOW(), NOW()),
    ('Asteroids', 'Shooter', 'Atari 2600', '1981-07-01', 'Atari', 'E', 75, false, 'Single-player', 3, 'A space-themed shooter game where players control a spaceship in an asteroid field.', NOW(), NOW()),
    ('Beat ''Em & Eat ''Em', 'Adult', 'Atari 2600', '1982-01-01', 'Mystique', 'AO', 30, 'False', 'Single-player', 2, 'An adult-themed game where the player controls a naked woman to catch falling objects.', NOW(), NOW()),
    ('Chase the Chuckwagon', 'Maze', 'Atari 2600', '1983-01-01', 'Spectravision', 'E', 40, 'False', 'Single-player', 2, 'A promotional game for Purina Dog Food where the player guides a dog through a maze to reach the food.', NOW(), NOW()),
    ('Custer''s Revenge', 'Adult', 'Atari 2600', '1982-01-01', 'Mystique', 'AO', 20, 'False', 'Single-player', 1, 'A controversial adult-themed game where the player controls General Custer to reach a Native American woman.', NOW(), NOW()),
    ('Demon Attack', 'Shoot ''em up', 'Atari 2600', '1982-01-01', 'Imagic', 'E', 75, 'False', 'Single-player', 3, 'A space shooter game where the player defends their planet from waves of attacking demons.', NOW(), NOW()),
    ('Desert Falcon', 'Shoot ''em up', 'Atari 2600', '1987-01-01', 'Atari', 'E', 65, 'False', 'Single-player', 3, 'A pseudo-3D shooter game where the player controls a falcon flying over a desert, shooting enemies and collecting treasures.', NOW(), NOW()),
    ('E.T. the Extra-Terrestrial', 'Adventure', 'Atari 2600', '1982-01-01', 'Atari', 'E', 25, 'False', 'Single-player', 2, 'An infamous game based on the movie E.T., where the player helps E.T. find pieces of a phone to call home.', NOW(), NOW()),
    ('Frogger', 'Arcade', 'Atari 2600', '1981-01-01', 'Konami', 'E', 80, 'False', 'Single-player', 3, 'A classic arcade game where the player guides a frog across a busy road and a river to reach its home.', NOW(), NOW()),
    ('Karate', 'Fighting', 'Atari 2600', '1982-01-01', 'Ultravision', 'E', '50', 'False', 'Single-player', '3', 'Karate is a one-on-one fighting game featuring various martial arts moves.', NOW(), NOW()),
    ('Missile Command', 'Arcade', 'Atari 2600', '1981-07-01', 'Atari', 'E (Everyone)', 80, FALSE, 'Single Player', 3, 'Player defends cities from being destroyed by a barrage of missiles', NOW(), NOW()),
    ('Pac-Man', 'Arcade', 'Atari 2600', '1982-05-01', 'Atari', 'E (Everyone)', 70, FALSE, 'Single Player', 2, 'Player navigates Pac-Man through a maze containing dots and four ghosts', NOW(), NOW()),
    ('Pitfall!', 'Platform', 'Atari 2600', '1982-04-20', 'Activision', 'E (Everyone)', 85, FALSE, 'Single Player', 3, 'Player controls Pitfall Harry and is tasked with collecting all the treasures in a jungle', NOW(), NOW()),
    ('River Raid', 'Shooter', 'Atari 2600', '1982-11-01', 'Activision', 'E (Everyone)', 85, FALSE, 'Single Player', 3, 'Player controls a jet up the River of No Return in a raid behind enemy lines', NOW(), NOW()),
    ('Sneak ''n Peek', 'Hide and Seek', 'Atari 2600', '1982-01-01', 'US Games', 'E (Everyone)', 60, TRUE, 'Two Players', 1, 'A game of hide and seek where one player hides and the other seeks', NOW(), NOW()),
    ('Space Invaders', 'Fixed Shooter', 'Atari 2600', '1980-01-01', 'Taito', 'E (Everyone)', 80, TRUE, 'Single Player, Two Players', 3, 'Player controls a laser cannon moving horizontally across the bottom of the screen, firing at descending aliens', NOW(), NOW()),
    ('Swordquest: Waterworld', 'Action', 'Atari 2600', '1983-01-01', 'Atari', 'E (Everyone)', 70, FALSE, 'Single Player', 4, 'Third in the Swordquest adventure game series where player navigates a hero through a series of screens to find items', NOW(), NOW()),
    ('Universal Chaos', 'Multi-directional Shooter', 'Atari 2600', '1983-01-01', 'Telesys', 'E (Everyone)', 70, TRUE, 'Single Player, Two Players', 3, 'Player controls a spacecraft and must destroy enemy ships', NOW(), NOW()),
    ('Yars'' Revenge', 'Shooter', 'Atari 2600', '1982-05-01', 'Atari', 'E', 70, false, 'Single-player', 3, 'A single-player game where the player controls a creature called a Yar who must nibble or shoot through a barrier in order to fire his Zorlon Cannon into the breach.', NOW(), NOW());
    """)
  end

  def nes_games() do
    Repo.run_sql("DELETE FROM games WHERE console_name = 'NES'")

    Repo.run_sql("""
    INSERT INTO games
    (game_name, genre, console_name, release_date, developer, maturity_rating, gameplay_rating, multiplayer, player_mode, difficulty, description, inserted_at, updated_at)
    VALUES
    ('Action 52', 'Compilation', 'NES', '1991-09-01', 'Active Enterprises', 'E', 25, FALSE, 'Single-player', 3, 'A compilation of 52 different games.', NOW(), NOW()),
    ('Back to the Future', 'Action, Adventure', 'NES', '1989-09-01', 'Beam Software', 'E', 40, FALSE, 'Single-player', 2, 'Based on the popular movie, help Marty McFly travel through time.', NOW(), NOW()),
    ('Castlevania', 'Platform, Action', 'NES', '1986-09-26', 'Konami', 'E', 85, FALSE, 'Single-player', 4, 'Take control of Simon Belmont and defeat Dracula.', NOW(), NOW()),
    ('Contra', 'Run and gun', 'NES', '1988-02-09', 'Konami', 'E', 88, TRUE, 'Single-player, Co-op', 4, 'Play as a commando and fight through waves of enemies.', NOW(), NOW()),
    ('Dr. Jekyll and Mr. Hyde', 'Action', 'NES', '1988-04-08', 'Advance Communication Company', 'E', 22, FALSE, 'Single-player', 3, 'Play as Dr. Jekyll and Mr. Hyde as they navigate their split personalities.', NOW(), NOW()),
    ('Dragon Warrior', 'Role-playing', 'NES', '1986-05-27', 'Chunsoft', 'E', 80, FALSE, 'Single-player', 3, 'Embark on a quest to save the kingdom from the Dragonlord.', NOW(), NOW()),
    ('Final Fantasy', 'Role-playing', 'NES', '1987-12-18', 'Square', 'E', 83, FALSE, 'Single-player', 4, 'Create a team of warriors and save the world from the evil forces.', NOW(), NOW()),
    ('Friday the 13th', 'Survival horror', 'NES', '1989-02-01', 'Atlus', 'E', 45, FALSE, 'Single-player', 3, 'Protect the camp counselors from Jason Voorhees.', NOW(), NOW()),
    ('Karate Champ', 'Fighting', 'NES', '1986-01-01', 'Technos Japan', 'E', 65, TRUE, 'Single-player, Versus', 3, 'Compete in a martial arts tournament.', NOW(), NOW()),
    ('Kirby''s Adventure', 'Platform', 'NES', '1993-03-23', 'HAL Laboratory', 'E', 88, FALSE, 'Single-player', 2, 'Help Kirby save Dream Land from the evil King Dedede.', NOW(), NOW()),
    ('Mega Man 2', 'Action, Platform', 'NES', '1988-12-24', 'Capcom', 'E', 90, FALSE, 'Single-player', 3, 'Play as Mega Man and defeat the evil Dr. Wily.', NOW(), NOW()),
    ('Metroid', 'Action, Adventure', 'NES', '1986-08-06', 'Nintendo R&D1', 'E', 88, FALSE, 'Single-player', 4, 'Play as Samus Aran and explore the planet Zebes.', NOW(), NOW()),
    ('Mike Tyson''s Punch-Out!!', 'Sports', 'NES', '1987-10-18', 'Nintendo R&D3', 'Everyone', '90', 'False', 'Single-player', '4', 'Boxing game where the player, as Little Mac, fights his way up the ranks to face Mike Tyson.', NOW(), NOW()),
    ('Super Mario Bros. 3', 'Platformer', 'NES', '1990-02-12', 'Nintendo', 'Everyone', '94', 'False', 'Single-player', '3', 'Mario and Luigi embark on a quest to save Princess Toadstool and the rulers of seven kingdoms from Bowser and his children.', NOW(), NOW()),
    ('Super Pitfall', 'Platformer', 'NES', '1987-09-05', 'Micronics', 'Everyone', '45', 'False', 'Single-player', '3', 'Guide Pitfall Harry through a treacherous jungle and underground caverns to find a lost treasure and rescue his niece.', NOW(), NOW()),
    ('The Legend of Zelda', 'Action-Adventure', 'NES', '1987-08-22', 'Nintendo', 'Everyone', '89', 'False', 'Single-player', '3', 'Embark on a quest as Link to collect the Triforce pieces and save Princess Zelda from the evil Ganon.', NOW(), NOW()),
    ('The Uncanny X-Men', 'Action', 'NES', '1989-12-01', 'LJN', 'Everyone', '35', 'True', 'Single-player, Multiplayer', '2', 'Control X-Men characters to defeat Magneto and other villains in this side-scrolling action game.', NOW(), NOW()),
    ('Where''s Waldo?', 'Puzzle', 'NES', '1991-09-01', 'Bethesda Softworks', 'Everyone', '30', 'False', 'Single-player', '1', 'Solve a series of puzzles by finding Waldo in various scenes.', NOW(), NOW());
    """)
  end
end
