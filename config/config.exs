# This file is responsible for configuring your umbrella
# and **all applications** and their dependencies with the
# help of the Config module.
#
# Note that all applications in your umbrella share the
# same configuration and dependencies, which is why they
# all use the same configuration file. If you want different
# configurations or dependencies per app, it is best to
# move said applications out of the umbrella.
import Mix.Config

import_config "../apps/*/config/config.exs"

config :phoenix, :serve_endpoints, true

config :entrance,              
  repo: Db.Repo,
  security_module: Entrance.Auth.Bcrypt,
  user_module: Db.Accounts.User,
  default_authenticable_field: :email

config :proxy, 
  # any Cowboy options are allowed
  http: [:inet6, port: 80],
  https: [:inet6, port: 443],
  backends: [
    %{
      host: ~r{matx\.(se|nu)$},
      phoenix_endpoint: MatxWeb.Endpoint
    },
    %{
      host: ~r{blippx\.(se|nu)$},
      phoenix_endpoint: BlippxWeb.Endpoint
    },
    %{
      host: ~r/localhost/,
      phoenix_endpoint: MatxWeb.Endpoint
    },
    %{
      host: ~r/127.0.0.1/,
      phoenix_endpoint: MatxWeb.Endpoint
    }
  ]

# Configure ecto_repo and generators
config :db,
  ecto_repos: [Db.Repo],
  generators: [context_app: :db]

config :proxy,
  ecto_repos: [Db.Repo],
  generators: [context_app: :db]

config :matx,
  ecto_repos: [Db.Repo],
  generators: [context_app: :db]

config :blippx,
  ecto_repos: [Db.Repo],
  generators: [context_app: :db]

# Sample configuration:
#
#     config :logger, :console,
#       level: :info,
#       format: "$date $time [$level] $metadata$message\n",
#       metadata: [:user_id]
#

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
