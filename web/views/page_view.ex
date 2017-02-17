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

  @doc"""
  The visual propeties of a cell are marked using css classes.
  """
  def classes_for_cell(%Maze{} = maze, v) do
    g = maze.graph
    trs = trails(maze)
    obs = objects(maze)

    t = if Grid.has_top_path(g, v) do "top" else "" end
    r = if Grid.has_right_path(g, v) do "right" else "" end
    l = if Grid.has_left_path(g, v) do "left" else "" end
    b = if Grid.has_bottom_path(g, v) do "bottom" else "" end

    obj_class = Map.get(obs, v, [])
      |> Enum.map(fn x -> to_string(x) end)
      |> Enum.join(" ")
    tr_class = Map.get(trs, v, [])
      |> Enum.map(fn x -> to_string(x) <> "-trail" end)
      |> Enum.join(" ")
    "#{b} #{t} #{l} #{r} #{obj_class} #{tr_class}"
  end


  def rows(%Digraph{} = g) do
    Enum.reverse Grid.rows(g)
  end

  def rows(x), do: x


  @doc """
    V -> objects lookup
  """
  def objects(m) do
    locations = for {obj, v} <- m.objects do
      {v, obj}
    end
    cells = Enum.reduce locations, %{}, fn({v, obj}, acc) ->
      xs = Map.get(acc, v, [])
      xs = xs ++ [obj]
      put_in acc[v], xs
    end
  end

  @doc """
   V -> trail lookup
  """
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

  def cell_content(maze, c, dfs, bfs) do
    bfs[c]
  end
end
