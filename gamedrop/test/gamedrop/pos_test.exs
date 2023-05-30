defmodule Gamedrop.PosTest do
  use Gamedrop.DataCase

  alias Gamedrop.Pos

  describe "gameplays" do
    alias Gamedrop.Pos.Gameplay

    import Gamedrop.PosFixtures

    @invalid_attrs %{
      console_name: nil,
      game_name: nil,
      gameplay_types: nil,
      rental_cost: nil,
      top_rated: nil
    }

    test "list_gameplays/0 returns all gameplays" do
      gameplay = gameplay_fixture()
      assert Pos.list_gameplays() == [gameplay]
    end

    test "get_gameplay!/1 returns the gameplay with given id" do
      gameplay = gameplay_fixture()
      assert Pos.get_gameplay!(gameplay.id) == gameplay
    end

    test "create_gameplay/1 with valid data creates a gameplay" do
      valid_attrs = %{
        console_name: "some console_name",
        game_name: "some game_name",
        gameplay_types: ["option1", "option2"],
        rental_cost: "120.5",
        top_rated: true
      }

      assert {:ok, %Gameplay{} = gameplay} = Pos.create_gameplay(valid_attrs)
      assert gameplay.console_name == "some console_name"
      assert gameplay.game_name == "some game_name"
      assert gameplay.gameplay_types == ["option1", "option2"]
      assert gameplay.rental_cost == Decimal.new("120.5")
      assert gameplay.top_rated == true
    end

    test "create_gameplay/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_gameplay(@invalid_attrs)
    end

    test "update_gameplay/2 with valid data updates the gameplay" do
      gameplay = gameplay_fixture()

      update_attrs = %{
        console_name: "some updated console_name",
        game_name: "some updated game_name",
        gameplay_types: ["option1"],
        rental_cost: "456.7",
        top_rated: false
      }

      assert {:ok, %Gameplay{} = gameplay} = Pos.update_gameplay(gameplay, update_attrs)
      assert gameplay.console_name == "some updated console_name"
      assert gameplay.game_name == "some updated game_name"
      assert gameplay.gameplay_types == ["option1"]
      assert gameplay.rental_cost == Decimal.new("456.7")
      assert gameplay.top_rated == false
    end

    test "update_gameplay/2 with invalid data returns error changeset" do
      gameplay = gameplay_fixture()
      assert {:error, %Ecto.Changeset{}} = Pos.update_gameplay(gameplay, @invalid_attrs)
      assert gameplay == Pos.get_gameplay!(gameplay.id)
    end

    test "delete_gameplay/1 deletes the gameplay" do
      gameplay = gameplay_fixture()
      assert {:ok, %Gameplay{}} = Pos.delete_gameplay(gameplay)
      assert_raise Ecto.NoResultsError, fn -> Pos.get_gameplay!(gameplay.id) end
    end

    test "change_gameplay/1 returns a gameplay changeset" do
      gameplay = gameplay_fixture()
      assert %Ecto.Changeset{} = Pos.change_gameplay(gameplay)
    end
  end

  describe "consoles" do
    alias Gamedrop.Pos.Console

    import Gamedrop.PosFixtures

    @invalid_attrs %{
      company_name: nil,
      company_website: nil,
      console_name: nil,
      release_date: nil
    }

    test "list_consoles/0 returns all consoles" do
      console = console_fixture()
      assert Pos.list_consoles() == [console]
    end

    test "get_console!/1 returns the console with given id" do
      console = console_fixture()
      assert Pos.get_console!(console.id) == console
    end

    test "create_console/1 with valid data creates a console" do
      valid_attrs = %{
        company_name: "some company_name",
        company_website: "some company_website",
        console_name: "some console_name",
        release_date: ~D[2023-05-28]
      }

      assert {:ok, %Console{} = console} = Pos.create_console(valid_attrs)
      assert console.company_name == "some company_name"
      assert console.company_website == "some company_website"
      assert console.console_name == "some console_name"
      assert console.release_date == ~D[2023-05-28]
    end

    test "create_console/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_console(@invalid_attrs)
    end

    test "update_console/2 with valid data updates the console" do
      console = console_fixture()

      update_attrs = %{
        company_name: "some updated company_name",
        company_website: "some updated company_website",
        console_name: "some updated console_name",
        release_date: ~D[2023-05-29]
      }

      assert {:ok, %Console{} = console} = Pos.update_console(console, update_attrs)
      assert console.company_name == "some updated company_name"
      assert console.company_website == "some updated company_website"
      assert console.console_name == "some updated console_name"
      assert console.release_date == ~D[2023-05-29]
    end

    test "update_console/2 with invalid data returns error changeset" do
      console = console_fixture()
      assert {:error, %Ecto.Changeset{}} = Pos.update_console(console, @invalid_attrs)
      assert console == Pos.get_console!(console.id)
    end

    test "delete_console/1 deletes the console" do
      console = console_fixture()
      assert {:ok, %Console{}} = Pos.delete_console(console)
      assert_raise Ecto.NoResultsError, fn -> Pos.get_console!(console.id) end
    end

    test "change_console/1 returns a console changeset" do
      console = console_fixture()
      assert %Ecto.Changeset{} = Pos.change_console(console)
    end
  end

  describe "games" do
    alias Gamedrop.Pos.Game

    import Gamedrop.PosFixtures

    @invalid_attrs %{
      console_name: nil,
      description: nil,
      developer: nil,
      difficulty: nil,
      game_name: nil,
      gameplay_rating: nil,
      genre: nil,
      maturity_rating: nil,
      multiplayer: nil,
      player_mode: nil,
      release_date: nil
    }

    test "list_games/0 returns all games" do
      game = game_fixture()
      assert Pos.list_games() == [game]
    end

    test "get_game!/1 returns the game with given id" do
      game = game_fixture()
      assert Pos.get_game!(game.id) == game
    end

    test "create_game/1 with valid data creates a game" do
      valid_attrs = %{
        console_name: "some console_name",
        description: "some description",
        developer: "some developer",
        difficulty: 42,
        game_name: "some game_name",
        gameplay_rating: 42,
        genre: "some genre",
        maturity_rating: "some maturity_rating",
        multiplayer: true,
        player_mode: "some player_mode",
        release_date: ~D[2023-05-28]
      }

      assert {:ok, %Game{} = game} = Pos.create_game(valid_attrs)
      assert game.console_name == "some console_name"
      assert game.description == "some description"
      assert game.developer == "some developer"
      assert game.difficulty == 42
      assert game.game_name == "some game_name"
      assert game.gameplay_rating == 42
      assert game.genre == "some genre"
      assert game.maturity_rating == "some maturity_rating"
      assert game.multiplayer == true
      assert game.player_mode == "some player_mode"
      assert game.release_date == ~D[2023-05-28]
    end

    test "create_game/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_game(@invalid_attrs)
    end

    test "update_game/2 with valid data updates the game" do
      game = game_fixture()

      update_attrs = %{
        console_name: "some updated console_name",
        description: "some updated description",
        developer: "some updated developer",
        difficulty: 43,
        game_name: "some updated game_name",
        gameplay_rating: 43,
        genre: "some updated genre",
        maturity_rating: "some updated maturity_rating",
        multiplayer: false,
        player_mode: "some updated player_mode",
        release_date: ~D[2023-05-29]
      }

      assert {:ok, %Game{} = game} = Pos.update_game(game, update_attrs)
      assert game.console_name == "some updated console_name"
      assert game.description == "some updated description"
      assert game.developer == "some updated developer"
      assert game.difficulty == 43
      assert game.game_name == "some updated game_name"
      assert game.gameplay_rating == 43
      assert game.genre == "some updated genre"
      assert game.maturity_rating == "some updated maturity_rating"
      assert game.multiplayer == false
      assert game.player_mode == "some updated player_mode"
      assert game.release_date == ~D[2023-05-29]
    end

    test "update_game/2 with invalid data returns error changeset" do
      game = game_fixture()
      assert {:error, %Ecto.Changeset{}} = Pos.update_game(game, @invalid_attrs)
      assert game == Pos.get_game!(game.id)
    end

    test "delete_game/1 deletes the game" do
      game = game_fixture()
      assert {:ok, %Game{}} = Pos.delete_game(game)
      assert_raise Ecto.NoResultsError, fn -> Pos.get_game!(game.id) end
    end

    test "change_game/1 returns a game changeset" do
      game = game_fixture()
      assert %Ecto.Changeset{} = Pos.change_game(game)
    end
  end
end
