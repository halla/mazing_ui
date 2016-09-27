defmodule MazingUi.PageController do
  use MazingUi.Web, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
