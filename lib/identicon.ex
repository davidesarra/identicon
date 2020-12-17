defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input) |> :binary.bin_to_list
    %Image{hex: hex}
  end

  def pick_color(%Image{hex: [r, g, b | _tail]} = image) do
      %Image{image | color: {r, g, b}}
  end

  def build_grid(%Image{hex: hex} = image) do
    grid =
      hex
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index
    %Image{image | grid: grid}
  end

  def mirror_row(row) do
    [first, second, _third] = row
    row ++ [second, first]
  end
end
