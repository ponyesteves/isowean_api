# In this file, we load production configuration and secrets
# from environment variables. You can also hardcode secrets,
# although such is generally not recommended and you have to
# remember to add this file to your .gitignore.
import Config

database_url =
  System.get_env("DATABASE_URL") ||
    raise """
    environment variable DATABASE_URL is missing.
    For example: ecto://USER:PASS@HOST/DATABASE
    """

config :isowean_api, IsoweanApi.Repo,
  # ssl: true,
  url: database_url,
  pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

secret_key_base =
  System.get_env("SECRET_KEY_BASE") ||
    raise """
    environment variable SECRET_KEY_BASE is missing.
    You can generate one by calling: mix phx.gen.secret
    """

config :isowean_api, IsoweanApiWeb.Endpoint,
  http: [
    port: String.to_integer(System.get_env("PORT") || "4000"),
    transport_options: [socket_opts: [:inet6]]
  ],
  secret_key_base: secret_key_base

config :teamplace,
  credentials: %{
    client_id: System.get_env("TEAMPLACE_CLIENT_ID"),
    client_secret: System.get_env("TEAMPLACE_CLIENT_SECRET")
  }

config :teamplace,
  api_base: System.get_env("TEAMPLACE_API_BASE")

config :teamplace,
  bcra_token: System.get_env("TEAMPLACE_BCRA_TOKEN")

# ## Using releases (Elixir v1.9+)
#
# If you are doing OTP releases, you need to instruct Phoenix
# to start each relevant endpoint:
#

config :isowean_api, IsoweanApiWeb.Endpoint, server: true

#
# Then you can assemble a release by calling `mix release`.
# See `mix help release` for more information.
