defmodule GameWeb.GameView.Index do
  use Phoenix.LiveView
  alias GameWeb.Helpers

  def render(assigns) do
    ~L"""
    <section class="row row-top row-wrap">
    <%= Enum.map(@grids, fn {title, value} -> %>
      <div class="column column-center column-offset-10 column-33 custom-margin">
        <h2><%= String.capitalize(String.replace(Atom.to_string(title), "_", " ")) %></h2>
        <div>
          <%= Enum.map(0..map_size(value)-1, fn i -> %>
            <div class="row">
              <%= Enum.map(0..map_size(value[i])-1, fn j -> %>
                  <span class="column cell <%= case (value[i][j]) do
                    0 -> 'cell-#{title}-dark'
                    1 -> 'cell-#{title}'
                  end %> ">

                  </span>
              <% end) %>
            </div>
          <% end) %>
        </div>
      </div>
    <% end) %>
    </section>
    """
  end

  def mount(_session, socket) do
    if connected?(socket), do: Process.send_after(self(), :tick, 1000)
    {:ok, assign(socket, grids: Helpers.grids())}
  end

  @spec handle_info(:tick, Phoenix.LiveView.Socket.t()) :: {:noreply, any()}
  def handle_info(:tick, socket) do
    Process.send_after(self(), :tick, 1000)
    {:noreply, update(socket, :grids, &Map.new(&1, fn {k, v} -> {k, Game.new_grid(v)} end))}
  end
end
