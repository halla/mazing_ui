defmodule MazingUi.PageController do
  use MazingUi.Web, :controller
  alias Mazing.Maze
  alias Mazing.Graph
  alias Mazing.Dfs

  def index(conn, _params) do
    maze = %{graph: [], trails: %{}, objects: %{}}

    generators = Mazing.Generator.list_generators()

    dfs = nil #Dfs.dfs(maze, Enum.at(maze.nodes, 0))
    render conn, "index.html", maze: maze, dfs: dfs, bfs: nil, objects: nil, generators: generators
  end
end
