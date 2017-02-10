defmodule MazingUi.PageView do
  use MazingUi.Web, :view

  alias Mazing.Cell
  alias Mazing.Digraph
  alias Mazing.Grid

  def classes_for_cell(g, %Cell{} = c) do
    b = if c.bottom do "bottom" else "" end
    t = if c.top do "top" else "" end
    l = if c.left do "left" else "" end
    r = if c.right do "right" else "" end
    "#{b} #{t} #{l} #{r}"
  end

  def classes_for_cell(%Digraph{} = g, v) do
    t = if Grid.has_top_path(g, v) do "top" else "" end
    r = if Grid.has_right_path(g, v) do "right" else "" end
    l = if Grid.has_left_path(g, v) do "left" else "" end
    b = if Grid.has_bottom_path(g, v) do "bottom" else "" end
    "#{b} #{t} #{l} #{r}"
  end


  def rows(%Digraph{} = g) do
    Enum.reverse Grid.rows(g)
  end

  def rows(x), do: x

end
