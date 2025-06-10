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
      data_criacao: user.inserted_at,
      data_atualizacao: user.updated_at
    }
  end

  def transactions(%{transactions: transactions}) do
    %{transactions: Enum.map(transactions, &transaction_json/1)}
  end

  defp transaction_json(transaction) do
    %{
      id: transaction.id,
      descricao: transaction.descricao,
      valor: transaction.valor,
      tipo: transaction.tipo,
      data: transaction.data,
      tags: Enum.map(transaction.tags || [], &tag_json/1)
    }
  end

  def tags(%{tags: tags}) do
    %{tags: Enum.map(tags, &tag_json/1)}
  end

  defp tag_json(tag) do
    %{
      id: tag.id,
      nome: tag.nome
    }
  end
end
