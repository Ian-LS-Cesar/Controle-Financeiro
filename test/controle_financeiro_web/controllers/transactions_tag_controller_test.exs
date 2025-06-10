defmodule ControleFinanceiroWeb.TransactionsTagControllerTest do
  use ControleFinanceiroWeb.ConnCase

  import ControleFinanceiro.TransacoesFixtures

  alias ControleFinanceiro.Transacoes.TransactionsTag

  @create_attrs %{

  }
  @update_attrs %{

  }
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transactions_tags", %{conn: conn} do
      conn = get(conn, ~p"/api/transactions_tags")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transactions_tag" do
    test "renders transactions_tag when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/transactions_tags", transactions_tag: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/transactions_tags/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/transactions_tags", transactions_tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transactions_tag" do
    setup [:create_transactions_tag]

    test "renders transactions_tag when data is valid", %{conn: conn, transactions_tag: %TransactionsTag{id: id} = transactions_tag} do
      conn = put(conn, ~p"/api/transactions_tags/#{transactions_tag}", transactions_tag: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/transactions_tags/#{id}")

      assert %{
               "id" => ^id
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, transactions_tag: transactions_tag} do
      conn = put(conn, ~p"/api/transactions_tags/#{transactions_tag}", transactions_tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transactions_tag" do
    setup [:create_transactions_tag]

    test "deletes chosen transactions_tag", %{conn: conn, transactions_tag: transactions_tag} do
      conn = delete(conn, ~p"/api/transactions_tags/#{transactions_tag}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/transactions_tags/#{transactions_tag}")
      end
    end
  end

  defp create_transactions_tag(_) do
    transactions_tag = transactions_tag_fixture()
    %{transactions_tag: transactions_tag}
  end
end
