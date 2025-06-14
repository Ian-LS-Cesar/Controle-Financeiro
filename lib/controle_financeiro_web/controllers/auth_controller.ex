defmodule ControleFinanceiroWeb.AuthController do
  use ControleFinanceiroWeb, :controller

  def login(conn, %{"email" => email, "senha" => senha}) do
    case ControleFinanceiroWeb.Auth.Guardian.authenticate(email, senha) do
      {:ok, user, token} ->
        conn
        |> put_status(:ok)
        |> json(%{
          user: %{id: user.id, email: user.email},
          token: token
        })

      {:error, _reason} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Credenciais inválidas"})
    end
  end
end
