defmodule MazingUi.MazeChannel do
  @moduledoc """
  MazeChannel sends new mazes on demand to the client.
  """

  use MazingUi.Web, :channel
  alias Mazing.Maze
  alias Mazing.Dfs
  alias Mazing.Graph
  alias Phoenix.View
  alias MazingUi.PageView

  def join("maze:1", _params, socket) do
    :timer.send_interval(1000, :refresh)
    {:ok, socket}
  end


  @doc """
  Generate a new maze.
  """
  def handle_in("maze-me", _params, socket) do
    maze = Maze.generate_maze(:maze_server, 7)
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

    html = View.render_to_string PageView, "maze.html", maze: maze, dfs: dfs
    broadcast! socket, "new_maze", %{html: html}
    {:noreply, socket}
  end
end
