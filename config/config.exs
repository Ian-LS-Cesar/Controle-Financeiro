# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :controle_financeiro,
  ecto_repos: [ControleFinanceiro.Repo],
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :controle_financeiro, ControleFinanceiroWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: ControleFinanceiroWeb.ErrorHTML, json: ControleFinanceiroWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: ControleFinanceiro.PubSub,
  live_view: [signing_salt: "H53F+m3/"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :controle_financeiro, ControleFinanceiro.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  controle_financeiro: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.3",
  controle_financeiro: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :controle_financeiro, ControleFinanceiroWeb.Auth.Guardian,
  issuer: "controle_financeiro",
  secret_key: "lUExLCLDL87lEo3bdJagBjPe7TgyMhfna61/PjgKy7gKMYs3Vq+xAwC5xEC2emD3"

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
