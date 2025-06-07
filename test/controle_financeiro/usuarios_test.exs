defmodule ControleFinanceiro.UsuariosTest do
  use ControleFinanceiro.DataCase

  alias ControleFinanceiro.Usuarios

  describe "users" do
    alias ControleFinanceiro.Usuarios.User

    import ControleFinanceiro.UsuariosFixtures

    @invalid_attrs %{nome: nil, email: nil, senha: nil, data_criacao: nil, data_atualizacao: nil}

    test "list_users/0 returns all users" do
      user = user_fixture()
      assert Usuarios.list_users() == [user]
    end

    test "get_user!/1 returns the user with given id" do
      user = user_fixture()
      assert Usuarios.get_user!(user.id) == user
    end

    test "create_user/1 with valid data creates a user" do
      valid_attrs = %{nome: "some nome", email: "some email", senha: "some senha", data_criacao: ~U[2025-06-06 05:27:00Z], data_atualizacao: ~U[2025-06-06 05:27:00Z]}

      assert {:ok, %User{} = user} = Usuarios.create_user(valid_attrs)
      assert user.nome == "some nome"
      assert user.email == "some email"
      assert user.senha == "some senha"
      assert user.data_criacao == ~U[2025-06-06 05:27:00Z]
      assert user.data_atualizacao == ~U[2025-06-06 05:27:00Z]
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Usuarios.create_user(@invalid_attrs)
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      update_attrs = %{nome: "some updated nome", email: "some updated email", senha: "some updated senha", data_criacao: ~U[2025-06-07 05:27:00Z], data_atualizacao: ~U[2025-06-07 05:27:00Z]}

      assert {:ok, %User{} = user} = Usuarios.update_user(user, update_attrs)
      assert user.nome == "some updated nome"
      assert user.email == "some updated email"
      assert user.senha == "some updated senha"
      assert user.data_criacao == ~U[2025-06-07 05:27:00Z]
      assert user.data_atualizacao == ~U[2025-06-07 05:27:00Z]
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Usuarios.update_user(user, @invalid_attrs)
      assert user == Usuarios.get_user!(user.id)
    end

    test "delete_user/1 deletes the user" do
      user = user_fixture()
      assert {:ok, %User{}} = Usuarios.delete_user(user)
      assert_raise Ecto.NoResultsError, fn -> Usuarios.get_user!(user.id) end
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Usuarios.change_user(user)
    end
  end
end
