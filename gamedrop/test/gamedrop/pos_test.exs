defmodule Gamedrop.PosTest do
  use Gamedrop.DataCase

  alias Gamedrop.Pos

  describe "gameplays" do
    alias Gamedrop.Pos.Gameplay

    import Gamedrop.PosFixtures

    @invalid_attrs %{console_name: nil, game_name: nil, gameplay_type: nil, top_rated: nil}

    test "list_gameplays/0 returns all gameplays" do
      gameplay = gameplay_fixture()
      assert Pos.list_gameplays() == [gameplay]
    end

    test "get_gameplay!/1 returns the gameplay with given id" do
      gameplay = gameplay_fixture()
      assert Pos.get_gameplay!(gameplay.id) == gameplay
    end

    test "create_gameplay/1 with valid data creates a gameplay" do
      valid_attrs = %{console_name: "some console_name", game_name: "some game_name", gameplay_type: "some gameplay_type", top_rated: true}

      assert {:ok, %Gameplay{} = gameplay} = Pos.create_gameplay(valid_attrs)
      assert gameplay.console_name == "some console_name"
      assert gameplay.game_name == "some game_name"
      assert gameplay.gameplay_type == "some gameplay_type"
      assert gameplay.top_rated == true
    end

    test "create_gameplay/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_gameplay(@invalid_attrs)
    end

    test "update_gameplay/2 with valid data updates the gameplay" do
      gameplay = gameplay_fixture()
      update_attrs = %{console_name: "some updated console_name", game_name: "some updated game_name", gameplay_type: "some updated gameplay_type", top_rated: false}

      assert {:ok, %Gameplay{} = gameplay} = Pos.update_gameplay(gameplay, update_attrs)
      assert gameplay.console_name == "some updated console_name"
      assert gameplay.game_name == "some updated game_name"
      assert gameplay.gameplay_type == "some updated gameplay_type"
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

  describe "gameplays" do
    alias Gamedrop.Pos.Gameplay

    import Gamedrop.PosFixtures

    @invalid_attrs %{console_name: nil, game_name: nil, gameplay_types: nil, top_rated: nil}

    test "list_gameplays/0 returns all gameplays" do
      gameplay = gameplay_fixture()
      assert Pos.list_gameplays() == [gameplay]
    end

    test "get_gameplay!/1 returns the gameplay with given id" do
      gameplay = gameplay_fixture()
      assert Pos.get_gameplay!(gameplay.id) == gameplay
    end

    test "create_gameplay/1 with valid data creates a gameplay" do
      valid_attrs = %{console_name: "some console_name", game_name: "some game_name", gameplay_types: ["option1", "option2"], top_rated: true}

      assert {:ok, %Gameplay{} = gameplay} = Pos.create_gameplay(valid_attrs)
      assert gameplay.console_name == "some console_name"
      assert gameplay.game_name == "some game_name"
      assert gameplay.gameplay_types == ["option1", "option2"]
      assert gameplay.top_rated == true
    end

    test "create_gameplay/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Pos.create_gameplay(@invalid_attrs)
    end

    test "update_gameplay/2 with valid data updates the gameplay" do
      gameplay = gameplay_fixture()
      update_attrs = %{console_name: "some updated console_name", game_name: "some updated game_name", gameplay_types: ["option1"], top_rated: false}

      assert {:ok, %Gameplay{} = gameplay} = Pos.update_gameplay(gameplay, update_attrs)
      assert gameplay.console_name == "some updated console_name"
      assert gameplay.game_name == "some updated game_name"
      assert gameplay.gameplay_types == ["option1"]
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

  describe "gameplays" do
    alias Gamedrop.Pos.Gameplay

    import Gamedrop.PosFixtures

    @invalid_attrs %{console_name: nil, game_name: nil, gameplay_types: nil, rental_cost: nil, top_rated: nil}

    test "list_gameplays/0 returns all gameplays" do
      gameplay = gameplay_fixture()
      assert Pos.list_gameplays() == [gameplay]
    end

    test "get_gameplay!/1 returns the gameplay with given id" do
      gameplay = gameplay_fixture()
      assert Pos.get_gameplay!(gameplay.id) == gameplay
    end

    test "create_gameplay/1 with valid data creates a gameplay" do
      valid_attrs = %{console_name: "some console_name", game_name: "some game_name", gameplay_types: ["option1", "option2"], rental_cost: "120.5", top_rated: true}

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
      update_attrs = %{console_name: "some updated console_name", game_name: "some updated game_name", gameplay_types: ["option1"], rental_cost: "456.7", top_rated: false}

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
end
