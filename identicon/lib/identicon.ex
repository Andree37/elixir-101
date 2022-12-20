defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
  end

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    filtered_grid =
      Enum.filter(grid, fn {value, _index} = _ ->
        rem(value, 2) == 0
      end)

    %Identicon.Image{image | grid: filtered_grid}
  end

  def mirror_row([first, second, _tail] = row) do
    row ++ [second, first]
  end

  def build_grid(%Identicon.Image{hex: hex_list} = image) do
    grid =
      hex_list
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten()
      |> Enum.with_index()

    %Identicon.Image{image | grid: grid}
  end

  def pick_color(%Identicon.Image{hex: [red, green, blue | _rest]} = image) do
    %Identicon.Image{image | color: {red, green, blue}}
  end

  def hash_input(input) do
    hex =
      :crypto.hash(:md5, input)
      |> :binary.bin_to_list()

    %Identicon.Image{hex: hex}
  end
end
