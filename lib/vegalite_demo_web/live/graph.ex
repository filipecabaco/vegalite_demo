defmodule VegaliteDemoWeb.Live.Graph do
  use VegaliteDemoWeb, :live_component
  @impl true
  def update(_, socket) do
    spec =
      VegaLite.new(title: "Demo", width: :container, height: :container, padding: 5)
      |> VegaLite.data_from_values(fake_data())
      |> VegaLite.mark(:line)
      |> VegaLite.encode_field(:x, "date", type: :nominal)
      |> VegaLite.encode_field(:y, "total", type: :quantitative)
      |> VegaLite.to_spec()

    socket = assign(socket, id: socket.id)
    {:ok, push_event(socket, "vega_lite:#{socket.id}:init", %{"spec" => spec})}
  end

  @impl true
  def render(assigns) do
    ~H"""
    <div style="width:80%; height: 500px" id="graph" phx-hook="VegaLite" phx-update="ignore" data-id={@id}/>
    """
  end

  defp fake_data do
    today = Date.utc_today()
    until = today |> Date.add(10)

    Enum.map(Date.range(today, until), fn date ->
      %{total: Enum.random(1..100), date: Date.to_iso8601(date), name: "potato"}
    end)
  end
end
