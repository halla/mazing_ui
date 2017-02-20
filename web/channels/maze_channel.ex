defmodule MazingUi.MazeChannel do
  @moduledoc """
  MazeChannel sends new mazes on demand to the client.
  """

  use MazingUi.Web, :channel
  alias Mazing.Maze
  alias Mazing.Dfs
  alias Mazing.Traverse.Bfs
  alias Mazing.Graph
  alias Mazing.Digraph
  alias Phoenix.View
  alias MazingUi.PageView

  def join("maze:1", _params, socket) do
    :timer.send_interval(1000, :refresh)
    {:ok, socket}
  end


  @doc """
  Generate a new maze.
  """
  def handle_in("maze-me", %{ "generator" => generator }, socket) do
    options = %{
      generator: String.to_atom(generator),
      size: 9
    }
    maze = Maze.generate_maze(:maze_server, options)
    dfs = Dfs.dfs(maze.graph, 1)

    html = View.render_to_string PageView, "maze.html", maze: maze, dfs: dfs
    broadcast! socket, "new_maze", %{html: html}
    {:reply, :ok, socket}
  end

  @doc """
  Refresh maze state from the server. Push to clients.
  """
  def handle_info(:refresh, socket) do
    maze = Maze.get_maze(:maze_server)
    dfs = Dfs.dfs(maze.graph, 1)
    bfs = Bfs.traverse(maze.graph, div(Digraph.v(maze.graph), 2))
    html = View.render_to_string PageView, "maze.html", maze: maze, dfs: dfs, bfs: bfs
    broadcast! socket, "new_maze", %{html: html }
    {:noreply, socket}
  end
end
