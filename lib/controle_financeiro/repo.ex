defmodule ControleFinanceiro.Repo do
  use Ecto.Repo,
    otp_app: :controle_financeiro,
    adapter: Ecto.Adapters.Postgres
end
