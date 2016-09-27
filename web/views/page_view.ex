defmodule MazingUi.PageView do
  use MazingUi.Web, :view

  alias Mazing.Cell
  
  def classes_for_cell(%Cell{} = c) do
    b = if c.bottom do "bottom" else "" end
    t = if c.top do "top" else "" end
    l = if c.left do "left" else "" end
    r = if c.right do "right" else "" end
    "#{b} #{t} #{l} #{r}"
  end
end
