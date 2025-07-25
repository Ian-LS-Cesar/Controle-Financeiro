defmodule ControleFinanceiroWeb.TagControllerTest do
  use ControleFinanceiroWeb.ConnCase

  import ControleFinanceiro.CategoriasFixtures

  alias ControleFinanceiro.Categorias.Tag

  @create_attrs %{
    nome: "some nome",
    id_user: 42,
    data_criacao: ~U[2025-06-06 05:32:00Z],
    data_atualizacao: ~U[2025-06-06 05:32:00Z]
  }
  @update_attrs %{
    nome: "some updated nome",
    id_user: 43,
    data_criacao: ~U[2025-06-07 05:32:00Z],
    data_atualizacao: ~U[2025-06-07 05:32:00Z]
  }
  @invalid_attrs %{nome: nil, id_user: nil, data_criacao: nil, data_atualizacao: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all tags", %{conn: conn} do
      conn = get(conn, ~p"/api/tags")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create tag" do
    test "renders tag when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/tags", tag: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/tags/#{id}")

      assert %{
               "id" => ^id,
               "data_atualizacao" => "2025-06-06T05:32:00Z",
               "data_criacao" => "2025-06-06T05:32:00Z",
               "id_user" => 42,
               "nome" => "some nome"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/tags", tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update tag" do
    setup [:create_tag]

    test "renders tag when data is valid", %{conn: conn, tag: %Tag{id: id} = tag} do
      conn = put(conn, ~p"/api/tags/#{tag}", tag: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/tags/#{id}")

      assert %{
               "id" => ^id,
               "data_atualizacao" => "2025-06-07T05:32:00Z",
               "data_criacao" => "2025-06-07T05:32:00Z",
               "id_user" => 43,
               "nome" => "some updated nome"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, tag: tag} do
      conn = put(conn, ~p"/api/tags/#{tag}", tag: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete tag" do
    setup [:create_tag]

    test "deletes chosen tag", %{conn: conn, tag: tag} do
      conn = delete(conn, ~p"/api/tags/#{tag}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/tags/#{tag}")
      end
    end
  end

  defp create_tag(_) do
    tag = tag_fixture()
    %{tag: tag}
  end
end
