# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

run_server? = System.get_env("RENDER_HOSTNAME") == nil || true

# Configures the endpoint
config :synapsit, SynapsitWeb.Endpoint,
  url: [host: "www.synapsit.se"],
  secret_key_base: "qvsYvVSwsbUdrpXeKR87736NkpXWt6MB4Nm8GdVcxTYHOUG5OK/VofkIE5U0pDQc",
  render_errors: [view: SynapsitWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Synapsit.PubSub,
  live_view: [signing_salt: "w1yXZMvx"],
  server: run_server?

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
