defmodule ControleFinanceiroWeb.UserControllerTest do
  use ControleFinanceiroWeb.ConnCase

  import ControleFinanceiro.UsuariosFixtures

  alias ControleFinanceiro.Usuarios.User

  @create_attrs %{
    nome: "some nome",
    email: "some email",
    senha: "some senha",
    data_criacao: ~U[2025-06-06 05:27:00Z],
    data_atualizacao: ~U[2025-06-06 05:27:00Z]
  }
  @update_attrs %{
    nome: "some updated nome",
    email: "some updated email",
    senha: "some updated senha",
    data_criacao: ~U[2025-06-07 05:27:00Z],
    data_atualizacao: ~U[2025-06-07 05:27:00Z]
  }
  @invalid_attrs %{nome: nil, email: nil, senha: nil, data_criacao: nil, data_atualizacao: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, ~p"/api/users")
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create user" do
    test "renders user when data is valid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "data_atualizacao" => "2025-06-06T05:27:00Z",
               "data_criacao" => "2025-06-06T05:27:00Z",
               "email" => "some email",
               "nome" => "some nome",
               "senha" => "some senha"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, ~p"/api/users", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update user" do
    setup [:create_user]

    test "renders user when data is valid", %{conn: conn, user: %User{id: id} = user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, ~p"/api/users/#{id}")

      assert %{
               "id" => ^id,
               "data_atualizacao" => "2025-06-07T05:27:00Z",
               "data_criacao" => "2025-06-07T05:27:00Z",
               "email" => "some updated email",
               "nome" => "some updated nome",
               "senha" => "some updated senha"
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, user: user} do
      conn = put(conn, ~p"/api/users/#{user}", user: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete user" do
    setup [:create_user]

    test "deletes chosen user", %{conn: conn, user: user} do
      conn = delete(conn, ~p"/api/users/#{user}")
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, ~p"/api/users/#{user}")
      end
    end
  end

  defp create_user(_) do
    user = user_fixture()
    %{user: user}
  end
end
