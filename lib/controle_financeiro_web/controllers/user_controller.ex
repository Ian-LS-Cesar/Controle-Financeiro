defmodule ControleFinanceiroWeb.UserController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Usuarios
  alias ControleFinanceiro.Usuarios.User

  action_fallback ControleFinanceiroWeb.FallbackController

  def index(conn, _params) do
    users = Usuarios.list_users()
    render(conn, :index, users: users)
  end

  def create(conn, %{"user" => user_params}) do
    with {:ok, %User{} = user} <- Usuarios.create_user(user_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/users/#{user}")
      |> render(:show, user: user)
    end
  end

  def show(conn, %{"id" => id}) do
    user = Usuarios.get_user!(id)
    render(conn, :show, user: user)
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Usuarios.get_user!(id)

    with {:ok, %User{} = user} <- Usuarios.update_user(user, user_params) do
      render(conn, :show, user: user)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Usuarios.get_user!(id)

    with {:ok, %User{}} <- Usuarios.delete_user(user) do
      send_resp(conn, :no_content, "")
    end
  end
end
