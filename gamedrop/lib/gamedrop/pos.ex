defmodule Gamedrop.Pos do
  @moduledoc """
  The Pos context.
  """

  import Ecto.Query, warn: false
  alias Gamedrop.Repo

  alias Gamedrop.Pos.Gameplay

  @doc """
  Returns the list of gameplays.

  ## Examples

      iex> list_gameplays()
      [%Gameplay{}, ...]

  """
  def list_gameplays do
    Repo.all(Gameplay)
  end

  @doc """
  Gets a single gameplay.

  Raises `Ecto.NoResultsError` if the Gameplay does not exist.

  ## Examples

      iex> get_gameplay!(123)
      %Gameplay{}

      iex> get_gameplay!(456)
      ** (Ecto.NoResultsError)

  """
  def get_gameplay!(id), do: Repo.get!(Gameplay, id)

  @doc """
  Creates a gameplay.

  ## Examples

      iex> create_gameplay(%{field: value})
      {:ok, %Gameplay{}}

      iex> create_gameplay(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_gameplay(attrs \\ %{}) do
    %Gameplay{}
    |> Gameplay.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a gameplay.

  ## Examples

      iex> update_gameplay(gameplay, %{field: new_value})
      {:ok, %Gameplay{}}

      iex> update_gameplay(gameplay, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_gameplay(%Gameplay{} = gameplay, attrs) do
    gameplay
    |> Gameplay.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a gameplay.

  ## Examples

      iex> delete_gameplay(gameplay)
      {:ok, %Gameplay{}}

      iex> delete_gameplay(gameplay)
      {:error, %Ecto.Changeset{}}

  """
  def delete_gameplay(%Gameplay{} = gameplay) do
    Repo.delete(gameplay)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking gameplay changes.

  ## Examples

      iex> change_gameplay(gameplay)
      %Ecto.Changeset{data: %Gameplay{}}

  """
  def change_gameplay(%Gameplay{} = gameplay, attrs \\ %{}) do
    Gameplay.changeset(gameplay, attrs)
  end
end
