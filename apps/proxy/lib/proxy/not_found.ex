defmodule Proxy.Plug.NotFound do
    @moduledoc false
    @behaviour Plug
  
    import Plug.Conn
    require Logger
  
    @impl true
    def init(options) do
      options
    end
  
    @impl true
    def call(conn, opts) do
      Logger.debug("Proxy.NotFound call opts: #{inspect(opts)}")
  
      conn
      |> send_resp(404, "No backends matched")
    end
  end