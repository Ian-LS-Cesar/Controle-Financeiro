defmodule ControleFinanceiroWeb.TransactionControllerTest do
  use ControleFinanceiroWeb.ConnCase

  import ControleFinanceiro.TransacoesFixtures

  alias ControleFinanceiro.Transacoes.Transaction

  @create_attrs %{
    data: ~U[2025-06-06 05:31:00Z],
    descricao: "some descricao",
    valor: "120.5",
    tipo: :"0",
    id_user: 42,
    data_criacao: ~U[2025-06-06 05:31:00Z],
    data_atualizacao: ~U[2025-06-06 05:31:00Z]
  }
  @update_attrs %{
    data: ~U[2025-06-07 05:31:00Z],
    descricao: "some updated descricao",
    valor: "456.7",
    tipo: :"1",
    id_user: 43,
    data_criacao: ~U[2025-06-07 05:31:00Z],
    data_atualizacao: ~U[2025-06-07 05:31:00Z]
  }
  @invalid_attrs %{data: nil, descricao: nil, valor: nil, tipo: nil, id_user: nil, data_criacao: nil, data_atualizacao: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all transactions", %{conn: conn} do
      conn = get(conn, ~p"/api/transactions")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create transaction" do
    test "renders transaction when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/transactions", transaction: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/transactions/#{id}")

      assert %{
               "id" => ^id,
               "data" => "2025-06-06T05:31:00Z",
               "data_atualizacao" => "2025-06-06T05:31:00Z",
               "data_criacao" => "2025-06-06T05:31:00Z",
               "descricao" => "some descricao",
               "id_user" => 42,
               "tipo" => "0",
               "valor" => "120.5"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/transactions", transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update transaction" do
    setup [:create_transaction]

    test "renders transaction when data is valid", %{conn: conn, transaction: %Transaction{id: id} = transaction} do
      conn = put(conn, ~p"/api/transactions/#{transaction}", transaction: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/transactions/#{id}")

      assert %{
               "id" => ^id,
               "data" => "2025-06-07T05:31:00Z",
               "data_atualizacao" => "2025-06-07T05:31:00Z",
               "data_criacao" => "2025-06-07T05:31:00Z",
               "descricao" => "some updated descricao",
               "id_user" => 43,
               "tipo" => "1",
               "valor" => "456.7"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, transaction: transaction} do
      conn = put(conn, ~p"/api/transactions/#{transaction}", transaction: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete transaction" do
    setup [:create_transaction]

    test "deletes chosen transaction", %{conn: conn, transaction: transaction} do
      conn = delete(conn, ~p"/api/transactions/#{transaction}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/transactions/#{transaction}")
      end
    end
  end

  defp create_transaction(_) do
    transaction = transaction_fixture()
    %{transaction: transaction}
  end
end
