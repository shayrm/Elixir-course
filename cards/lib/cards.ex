defmodule Cards do
  @moduledoc """
  Documentation for Cards.\n
  Cards module provides methods for creating and handing a dack of cards
  """

  @doc """
  
  Returen a list of strings representing a deck of playing cards
  
  """

  def create_deck do
    # create two list of card that have value and type (suite)
    values = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten"]
    suites = ["Spades", "clubs", "Hearts", "Diamond"]
     
      for suit <- suites, value <- values do
        "#{value} of #{suit}"
      end
  end
  @doc """
  Shuffle the deck 
  """

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
  
  Detrmaines whether a deck contians a given card

  ## Examples

        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Spades")
        true

  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Divides a deck into a hand and the reminder of the deck.\n
  The `hand_size` argument indicate the number of cards should be in the hand

  ## Examples

        iex> deck = Cards.create_deck 
        iex> {hand, deck} = Cards.deal(deck, 1)
        iex> hand
        ["Ace of Spades"]


  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)  # the result will be tuplpe of { *the hand*, *the rest of the deck* }
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    {status, binary} = File.read(filename)
    
    case status do  # check the status of loading the filename
      :ok -> :erlang.binary_to_term(binary)
      :error -> "Could not read file, the file could not be found" 
    end
  end

  def loadItBetter(filename) do
    case File.read(filename) do
      {:ok, binary} -> :erlang.binary_to_term(binary)
      {:error, _reason} -> "File does not exist"
    end
  end
    
  def create_hand(hand_size) do
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end



end
