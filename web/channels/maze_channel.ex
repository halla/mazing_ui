defmodule MazingUi.MazeChannel do
  use MazingUi.Web, :channel
  alias Mazing.Maze
  alias Mazing.Graph
  alias Phoenix.View
  alias MazingUi.PageView

  def join("maze:1", _params, socket) do
    {:ok, socket}
  end

  def handle_in("maze-me", _params, socket) do
    maze =
      Graph.square_grid(7)
      |> Maze.binary_tree()
      |> Graph.as_grid()

    html = View.render_to_string PageView, "maze.html", maze: maze    
    broadcast! socket, "new_maze", %{html: html}
    {:reply, :ok, socket}

  end
end
