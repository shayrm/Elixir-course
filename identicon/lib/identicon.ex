defmodule Identicon do
  @moduledoc """
  Documentation for Identicon.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Identicon.hello
      :world

  """
  def hello do
    :world
  end

  def main(input) do
    input
    |> hash_input   # input will be used for hashing the string, the result is a struct hex
    |> pick_color
    |> build_grid
    |> filter_odd_squares
    |> build_pixel_map
    |> draw_image
    |> save_image(input)
  end
  
  def save_image(image, input) do
    File.write("#{input}.png", image)
  end

  def draw_image(%Identicon.Image{color: color, pixel_map: pixel_map}) do
    image = :egd.create(250, 250)
    fill = :egd.color(color)

     # run on each element
    Enum.each pixel_map, fn({start, stop}) -> 
      :egd.filledRectangle(image, start, stop, fill)
    end

    :egd.render(image)
  end
    
  def build_pixel_map(%Identicon.Image{grid: grid} = image) do
    pixel_map = 
      Enum.map grid, fn({_code, index}) ->
        horizantel = rem(index, 5) * 50
        vertical = div(index, 5) * 50

        top_left = {horizantel, vertical}
        bottom_righ = {horizantel + 50, vertical + 50} 
        {top_left, bottom_righ}

      end
    %Identicon.Image{image | pixel_map: pixel_map}
  end 

  def filter_odd_squares(%Identicon.Image{grid: grid} = image) do
    grid = 
      Enum.filter grid, fn({code, _index}) -> 
      rem(code, 2) == 0
      end
      %Identicon.Image{image | grid: grid}
  end

  def build_grid(%Identicon.Image{hex: hex} = image) do
    grid = 
      hex
      |> Enum.chunk(3)
      |> Enum.map(&mirror_row/1)
      |> List.flatten
      |> Enum.with_index
      %Identicon.Image{image | grid: grid}
      
  end

  def mirror_row(row) do
   # row will be something like [44, 220, 32]
   # at the end we want to mirror the row to be [ 44, 220, 32, 220, 44]

   [first, second | _tail] = row
   # to join a list we will need to use the join list sign ++

   row ++ [second, first]
  end

  def pick_color(%Identicon.Image{hex: [r, g, b | _tail]} = image) do
    # the long version
    # %Identicon.Image{hex: [r, g, b | _tail]} = image
    # the long version
    # %Identicon.Image{hex: hex_list} = image
    # [r, g, b | _tail] = hex_list
    %Identicon.Image { image | color: {r, g, b}}

  end

  def hash_input(input) do
    hex = :crypto.hash(:md5, input)
    |> :binary.bin_to_list
    %Identicon.Image{hex: hex}

  end


end
