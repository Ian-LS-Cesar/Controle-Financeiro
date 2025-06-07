defmodule ControleFinanceiroWeb.UserJSON do
  alias ControleFinanceiro.Usuarios.User

  @doc """
  Renders a list of users.
  """
  def index(%{users: users}) do
    %{data: for(user <- users, do: data(user))}
  end

  @doc """
  Renders a single user.
  """
  def show(%{user: user}) do
    %{data: data(user)}
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      nome: user.nome,
      email: user.email,
      senha: user.senha,
      data_criacao: user.data_criacao,
      data_atualizacao: user.data_atualizacao
    }
  end
end
