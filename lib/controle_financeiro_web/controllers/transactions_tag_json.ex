defmodule ControleFinanceiroWeb.TransactionsTagJSON do
  alias ControleFinanceiro.Transacoes.TransactionsTag

  @doc """
  Renders a list of transactions_tags.
  """
  def index(%{transactions_tags: transactions_tags}) do
    %{data: for(transactions_tag <- transactions_tags, do: data(transactions_tag))}
  end

  @doc """
  Renders a single transactions_tag.
  """
  def show(%{transactions_tag: transactions_tag}) do
    %{data: data(transactions_tag)}
  end

  defp data(%TransactionsTag{} = transactions_tag) do
    %{
      id: transactions_tag.id
    }
  end
end
