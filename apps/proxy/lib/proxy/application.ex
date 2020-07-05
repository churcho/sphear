defmodule Proxy.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  alias Phoenix.LiveReloader.Socket,  as: LiveReloadSocket
  alias Plug.Cowboy

  use Application
  require Logger

  defp websocket() do
    {
      "/socket",
      Phoenix.Endpoint.CowboyWebSocket,
      {
        Phoenix.Transports.WebSocket,
        {MatxWeb.Endpoint, MatxWeb.UserSocket, :websocket}
      }
    }
  end

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    port = to_port(80)
    dispatch = [{:_, [
      #websocket_handler("/socket", MatxWeb.Endpoint, {MatxWeb.UserSocket, )
      websocket(),
      {:_, Proxy.Cowboy2Handler, {nil, nil}}
    ]}]

    opts = [
      port: port,
      dispatch: dispatch
    ]

    children = [{Plug.Cowboy, scheme: :http, plug: {nil, nil}, options: opts}]

    opts2 = [strategy: :one_for_one, name: Proxy.Supervisor]


    Logger.info("successfully started proxy on port 80")

    Supervisor.start_link(children, opts2)
  end

  defp websocket_handler(path, endpoint, options) do
    {path, Phoenix.Endpoint.Cowboy2Handler, {endpoint, options}}
  end

  defp to_port(nil) do
    Logger.error "Server can't start because :port in config is nil, please use a valid port number"
    exit(:shutdown)
  end
  defp to_port(binary)  when is_binary(binary),   do: String.to_integer(binary)
  defp to_port(integer) when is_integer(integer), do: integer
  defp to_port({:system, env_var}), do: to_port(System.get_env(env_var))
end
