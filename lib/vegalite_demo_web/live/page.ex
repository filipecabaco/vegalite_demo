defmodule VegaliteDemoWeb.Live.Page do
  use VegaliteDemoWeb, :live_view

  @impl true
  def mount(_, _, socket) do
    {:ok, socket}
  end
end
