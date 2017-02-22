defmodule MazingUi.AgentChannel do
  use MazingUi.Web, :channel
  alias Phoenix.View
  alias MazingUi.PageView


  def join("agent:1", _params, socket) do
    :timer.send_interval(1000, :refresh)
    {:ok, socket}
  end


  def handle_info(:refresh, socket) do
    info = Mazing.Agent.Straightguy.agent_info()
    html = View.render_to_string(PageView, "agent_view.html", name: "Straightguy", info: info)
    broadcast! socket, "agent_info", %{html: html }
    {:noreply, socket}
  end

  def handle_in("move", %{"direction" => direction}, socket) do
    Mazing.Agent.Avatar.move(String.to_atom(direction))
    {:reply, :ok, socket}
  end
end
