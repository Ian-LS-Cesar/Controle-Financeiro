defmodule ControleFinanceiroWeb.TransactionJSON do
  alias ControleFinanceiro.Transacoes.Transaction

  @doc """
  Renders a list of transactions.
  """
  def index(%{transactions: transactions}) do
    %{data: for(transaction <- transactions, do: data(transaction))}
  end

  @doc """
  Renders a single transaction.
  """
  def show(%{transaction: transaction}) do
    %{
      id: transaction.id,
      descricao: transaction.descricao,
      valor: transaction.valor,
      tipo: transaction.tipo,
      data: transaction.data,
      tags: Enum.map(transaction.tags || [], fn tag ->
        %{
          id: tag.id,
          nome: tag.nome
        }
      end)
    }
  end

  defp data(%Transaction{} = transaction) do
    %{
      id: transaction.id,
      descricao: transaction.descricao,
      valor: transaction.valor,
      tipo: tipo_to_string(transaction.tipo),
      data: transaction.data,
      id_user: transaction.id_user,
      data_criacao: transaction.inserted_at,
      data_atualizacao: transaction.updated_at
    }
  end

  def tipo_to_string(:"0"), do: "Receita"
  def tipo_to_string(:"1"), do: "Despesa"
  def tipo_to_string(_), do: "Desconhecido"

end
