defmodule MazingUi.PageView do
  use MazingUi.Web, :view

  alias Mazing.Cell
  alias Mazing.Digraph
  alias Mazing.Grid
  alias Mazing.Maze

  def classes_for_cell(_, %Cell{} = c) do
    b = if c.bottom do "bottom" else "" end
    t = if c.top do "top" else "" end
    l = if c.left do "left" else "" end
    r = if c.right do "right" else "" end
    "#{b} #{t} #{l} #{r}"
  end

  def classes_for_cell(%Maze{} = maze, v) do
    g = maze.graph
    trs = trails(maze)
    t = if Grid.has_top_path(g, v) do "top" else "" end
    r = if Grid.has_right_path(g, v) do "right" else "" end
    l = if Grid.has_left_path(g, v) do "left" else "" end
    b = if Grid.has_bottom_path(g, v) do "bottom" else "" end
    obj = "" #if v == maze.objects.monsterino do "monsterino" else "" end
    obj2 = if v == maze.objects.randoomed do "randoomed" else "" end
    obj3 = if v == maze.objects.straightguy do "straightguy" else "" end

    obj4 = if v == Map.get(maze.objects, :green_dot, nil) do "green_dot" else "" end
    tr_class = Map.get(trs, v, [])
      |> Enum.map(fn x -> to_string(x) <> "-trail" end)
      |> Enum.join(" ")
    "#{b} #{t} #{l} #{r} #{obj} #{obj2} #{obj3} #{obj4} #{tr_class}"
  end


  def rows(%Digraph{} = g) do
    Enum.reverse Grid.rows(g)
  end

  def rows(x), do: x

  def trails(g) do

    marks = for {obj, trail} <- g.trails do
        for c <- :queue.to_list(trail) do
          {c, obj}
        end
    end

    cells = Enum.reduce List.flatten(marks), %{}, fn({v, obj}, acc) ->
      xs = Map.get(acc, v, [])
      xs = xs ++ [obj]
      put_in acc[v], xs
    end
  end
end
