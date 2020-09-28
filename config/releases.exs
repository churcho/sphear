import Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :db, Db.Repo,
  ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

#########################

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

synaps_key_base =
  System.get_env("SYNAPS_SECRET_KEY_BASE") ||
    raise """
    environment variable SYNAPS_SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

matx_key_base =
    System.get_env("MATX_SECRET_KEY_BASE") ||
      raise """
      environment variable MATX_SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

##########################

config :matx, MatxWeb.Endpoint,
  http: [
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: matx_key_base,
  server: false

config :synaps, SynapsWeb.Endpoint,
  http: [
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: synaps_key_base,
  server: false

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#

config :proxy, Proxy.Endpoint, server: true
#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
