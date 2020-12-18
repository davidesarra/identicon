defmodule Identicon do
  def main(input) do
    input
    |> hash_input
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> safe_image(input)
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

  def filter_odd_squares(%Image{grid: grid} = image) do
    grid = Enum.filter grid, fn({code, _index}) ->
      rem(code, 2) == 0
    end
    %Image{image | grid: grid}
  end

  def build_pixel_map(%Image{grid: grid} = image) do
    block_side = 50
    num_row_blocks = 5
    pixel_map = Enum.map grid, fn({_code, index}) ->
      horizontal = rem(index, num_row_blocks) * block_side
      vertical = div(index, num_row_blocks) * block_side
      top_left = {horizontal, vertical}
      bottom_right = {horizontal + block_side, vertical + block_side}
      {top_left, bottom_right}
    end
    %Image{image | pixel_map: pixel_map}
  end

  def draw_image(%Image{color: color, pixel_map: pixel_map}) do
    num_side_pixels = 250
    image = :egd.create(num_side_pixels, num_side_pixels)
    fill = :egd.color(color)
    Enum.each pixel_map, fn({start, stop}) ->
      :egd.filledRectangle(image, start, stop, fill)
    end
    :egd.render(image)
  end

  def safe_image(image, input) do
    File.write("#{input}.png", image)
  end
end
