defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

#  test "greets the world" do
#    assert Cards.hello() == :world
#  end

  test "Create deck with 40 cards" do
    deck_lenght = length(Cards.create_deck)
    assert deck_lenght == 40
  end

  test "suffeling a deck randomizes it" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
    # it is possible to write the same with refute
    # refute deck == Cards.shuffle(deck)
  end

end
