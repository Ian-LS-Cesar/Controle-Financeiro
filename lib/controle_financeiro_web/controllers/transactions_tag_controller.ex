defmodule ControleFinanceiroWeb.TransactionsTagController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Transacoes
  alias ControleFinanceiro.Transacoes.TransactionsTag

  action_fallback ControleFinanceiroWeb.FallbackController

  def index(conn, _params) do
    transactions_tags = Transacoes.list_transactions_tags()
    render(conn, :index, transactions_tags: transactions_tags)
  end

  def create(conn, %{"transactions_tag" => transactions_tag_params}) do
    with {:ok, %TransactionsTag{} = transactions_tag} <- Transacoes.create_transactions_tag(transactions_tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/transactions_tags/#{transactions_tag}")
      |> render(:show, transactions_tag: transactions_tag)
    end
  end

  def show(conn, %{"id" => id}) do
    transactions_tag = Transacoes.get_transactions_tag!(id)
    render(conn, :show, transactions_tag: transactions_tag)
  end

  def update(conn, %{"id" => id, "transactions_tag" => transactions_tag_params}) do
    transactions_tag = Transacoes.get_transactions_tag!(id)

    with {:ok, %TransactionsTag{} = transactions_tag} <- Transacoes.update_transactions_tag(transactions_tag, transactions_tag_params) do
      render(conn, :show, transactions_tag: transactions_tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    transactions_tag = Transacoes.get_transactions_tag!(id)

    with {:ok, %TransactionsTag{}} <- Transacoes.delete_transactions_tag(transactions_tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
