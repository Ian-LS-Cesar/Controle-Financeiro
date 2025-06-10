defmodule ControleFinanceiroWeb.Auth.Pipeline do
  use Guardian.Plug.Pipeline,
    otp_app: :controle_financeiro,
    module: ControleFinanceiroWeb.Auth.Guardian,
    error_handler: ControleFinanceiroWeb.Auth.ErrorHandler

  plug Guardian.Plug.VerifyHeader, scheme: "Bearer"
  plug Guardian.Plug.LoadResource, allow_blank: true
end
