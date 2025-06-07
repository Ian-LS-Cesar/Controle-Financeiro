defmodule ControleFinanceiro.CategoriasTest do
  use ControleFinanceiro.DataCase

  alias ControleFinanceiro.Categorias

  describe "tags" do
    alias ControleFinanceiro.Categorias.Tag

    import ControleFinanceiro.CategoriasFixtures

    @invalid_attrs %{nome: nil, id_user: nil, data_criacao: nil, data_atualizacao: nil}

    test "list_tags/0 returns all tags" do
      tag = tag_fixture()
      assert Categorias.list_tags() == [tag]
    end

    test "get_tag!/1 returns the tag with given id" do
      tag = tag_fixture()
      assert Categorias.get_tag!(tag.id) == tag
    end

    test "create_tag/1 with valid data creates a tag" do
      valid_attrs = %{nome: "some nome", id_user: 42, data_criacao: ~U[2025-06-06 05:32:00Z], data_atualizacao: ~U[2025-06-06 05:32:00Z]}

      assert {:ok, %Tag{} = tag} = Categorias.create_tag(valid_attrs)
      assert tag.nome == "some nome"
      assert tag.id_user == 42
      assert tag.data_criacao == ~U[2025-06-06 05:32:00Z]
      assert tag.data_atualizacao == ~U[2025-06-06 05:32:00Z]
    end

    test "create_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Categorias.create_tag(@invalid_attrs)
    end

    test "update_tag/2 with valid data updates the tag" do
      tag = tag_fixture()
      update_attrs = %{nome: "some updated nome", id_user: 43, data_criacao: ~U[2025-06-07 05:32:00Z], data_atualizacao: ~U[2025-06-07 05:32:00Z]}

      assert {:ok, %Tag{} = tag} = Categorias.update_tag(tag, update_attrs)
      assert tag.nome == "some updated nome"
      assert tag.id_user == 43
      assert tag.data_criacao == ~U[2025-06-07 05:32:00Z]
      assert tag.data_atualizacao == ~U[2025-06-07 05:32:00Z]
    end

    test "update_tag/2 with invalid data returns error changeset" do
      tag = tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Categorias.update_tag(tag, @invalid_attrs)
      assert tag == Categorias.get_tag!(tag.id)
    end

    test "delete_tag/1 deletes the tag" do
      tag = tag_fixture()
      assert {:ok, %Tag{}} = Categorias.delete_tag(tag)
      assert_raise Ecto.NoResultsError, fn -> Categorias.get_tag!(tag.id) end
    end

    test "change_tag/1 returns a tag changeset" do
      tag = tag_fixture()
      assert %Ecto.Changeset{} = Categorias.change_tag(tag)
    end
  end
end
