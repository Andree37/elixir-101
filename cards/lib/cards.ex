defmodule Cards do
  def create_deck do
    numbers = ["Ace", "Two", "Three", "Four", "Five"]
    suits = ["Hearts", "Diamonds", "Clubs", "Spades"]

    for number <- numbers, suit <- suits do
      "#{number} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  def deal(deck, count) do
    Enum.split(deck, count)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    {status, binary} = File.read(filename)

    case status do
      :ok -> :erlang.binary_to_term(binary)
      :error -> "File does not exist"
    end
  end
end
