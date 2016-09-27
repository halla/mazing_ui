defmodule MazingUi.PageController do
  use MazingUi.Web, :controller
  alias Mazing.Maze
  alias Mazing.Graph

  def index(conn, _params) do
    g = Graph.square_grid(7)

    maze = Graph.as_grid(Maze.binary_tree(g))
    render conn, "index.html", maze: maze
  end
end
