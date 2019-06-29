defmodule MmoLiveviewWeb.PageController do
  use MmoLiveviewWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end

defmodule MmoLiveviewWeb.ThermostatView do
  use Phoenix.LiveView

  def render(assigns) do
    ~L"""
    <form phx-change="change_name">
      Name:<input width=400 name="name" />
    </form>
    <div class="thermostat" phx-keydown="update_temp" phx-target="window">
      <svg x=0 y=0 width=500 height=500 style="background-color: #ddd">
      <%= for chara <- @list do %>
        <polygon points="<%= chara.x - 10 %> <%= chara.y - 10 %>, <%= chara.x + 10 %> <%= chara.y - 10 %>, <%= chara.x + 10 %> <%= chara.y + 10 %>, <%= chara.x - 10 %> <%= chara.y + 10 %>" fill="#99f" />
        <text x="<%= chara.x %>" y="<%= chara.y %>" font-family="Verdana" font-size="18">
          <%= chara.name %>
        </text>
      <% end %>
      </svg>
    </div>
    <div><%= inspect(@list) %></div>
    """
  end

  @interval 50
  def mount(_session, socket) do
    if connected?(socket), do: Process.send_after(self(), :render, @interval)
    IO.puts(socket.id)
    MmoLiveview.Game.join(socket.id, "")
    {:ok, assign(socket, my_id: socket.id, list: MmoLiveview.Game.list())}
  end

  def handle_info(:render, socket) do
    Process.send_after(self(), :render, @interval)
    {:noreply, assign(socket, my_id: socket.id, list: MmoLiveview.Game.list())}
  end

  def terminate(_session, socket) do
    IO.puts("leave: #{socket.id}")
    MmoLiveview.Game.leave(socket.id)
    :ok
  end

  def handle_event("change_name", %{"name" => name}, socket) do
    MmoLiveview.Game.update_name(socket.id, name)
    {:noreply, assign(socket, my_id: socket.id, list: MmoLiveview.Game.list())}
  end

  @velocity 5
  def handle_event("update_temp", "ArrowUp", socket) do
    MmoLiveview.Game.move(socket.id, 0, -@velocity)
    {:noreply, assign(socket, my_id: socket.id, list: MmoLiveview.Game.list())}
  end

  def handle_event("update_temp", "ArrowDown", socket) do
    MmoLiveview.Game.move(socket.id, 0, @velocity)
    {:noreply, assign(socket, my_id: socket.id, list: MmoLiveview.Game.list())}
  end

  def handle_event("update_temp", "ArrowLeft", socket) do
    MmoLiveview.Game.move(socket.id, -@velocity, 0)
    {:noreply, assign(socket, my_id: socket.id, list: MmoLiveview.Game.list())}
  end

  def handle_event("update_temp", "ArrowRight", socket) do
    MmoLiveview.Game.move(socket.id, @velocity, 0)
    {:noreply, assign(socket, my_id: socket.id, list: MmoLiveview.Game.list())}
  end

  def handle_event("update_temp", _key, socket) do
    IO.puts(socket.id)
    {:noreply, socket}
  end
end
