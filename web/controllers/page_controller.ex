defmodule MazingUi.PageController do
  use MazingUi.Web, :controller
  alias Mazing.Maze
  alias Mazing.Graph
  alias Mazing.Dfs

  def index(conn, _params) do
    g = Graph.square_grid(7)

    maze = Graph.as_grid(Maze.binary_tree(g))
    dfs = nil #Dfs.dfs(maze, Enum.at(maze.nodes, 0))
    render conn, "index.html", maze: %{graph: maze}, dfs: @dfs
  end
end
