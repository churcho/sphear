defmodule Proxy.Endpoint do
  use Phoenix.Endpoint, otp_app: :proxy

  def init(_key, config) do
    {:ok, config}
  end
end