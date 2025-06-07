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
    %{data: data(transaction)}
  end

  defp data(%Transaction{} = transaction) do
    %{
      id: transaction.id,
      descricao: transaction.descricao,
      valor: transaction.valor,
      tipo: transaction.tipo,
      data: transaction.data,
      id_user: transaction.id_user,
      data_criacao: transaction.data_criacao,
      data_atualizacao: transaction.data_atualizacao
    }
  end
end
