defmodule ControleFinanceiroWeb.TransactionController do
  use ControleFinanceiroWeb, :controller
  import Ecto.Query, only: [from: 2]

  alias ControleFinanceiro.Transacoes
  alias ControleFinanceiro.Transacoes.Transaction

  action_fallback ControleFinanceiroWeb.FallbackController

  def index(conn, _params) do
    transactions = Transacoes.list_transactions()
    render(conn, :index, transactions: transactions)
  end

  def create(conn, %{"transaction" => transaction_params}) do
    tags_ids = Map.get(transaction_params, "tags", [])

    changeset =
      %ControleFinanceiro.Transacoes.Transaction{}
      |> ControleFinanceiro.Transacoes.Transaction.changeset(transaction_params)
      |> Ecto.Changeset.put_assoc(:tags, get_tags(tags_ids))

    case ControleFinanceiro.Repo.insert(changeset) do
      {:ok, transaction} ->
        transaction = ControleFinanceiro.Repo.preload(transaction, :tags)
        json(conn, ControleFinanceiroWeb.TransactionJSON.show(%{transaction: transaction}))

      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(ControleFinanceiroWeb.ChangesetJSON.error(%{changeset: changeset}))
    end
  end

  def show(conn, %{"id" => id}) do
    transaction = Transacoes.get_transaction!(id)
    render(conn, :show, transaction: transaction)
  end

  def update(conn, %{"id" => id, "transaction" => transaction_params}) do
    transaction = Transacoes.get_transaction!(id)

    with {:ok, %Transaction{} = transaction} <- Transacoes.update_transaction(transaction, transaction_params) do
      conn
      |> put_view(ControleFinanceiroWeb.TransactionJSON)
      |> render(:show, transaction: transaction)
    end
  end

  def delete(conn, %{"id" => id}) do
    transaction = Transacoes.get_transaction!(id)

    with {:ok, %Transaction{}} <- Transacoes.delete_transaction(transaction) do
      send_resp(conn, :no_content, "")
    end
  end

  defp get_tags([]), do: []

  defp get_tags(ids) do
    query = from t in ControleFinanceiro.Categorias.Tag, where: t.id in ^ids
    ControleFinanceiro.Repo.all(query)
  end
end
