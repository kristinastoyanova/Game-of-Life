defmodule GameWeb.PageController do
  use GameWeb, :controller
  alias Phoenix.LiveView.Controller

  def index(conn, _params) do
    Controller.live_render(conn, GameWeb.GameView.Index, session: %{})
  end
end
