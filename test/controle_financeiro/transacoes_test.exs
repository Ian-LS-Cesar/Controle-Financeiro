defmodule ControleFinanceiro.TransacoesTest do
  use ControleFinanceiro.DataCase

  alias ControleFinanceiro.Transacoes

  describe "transactions" do
    alias ControleFinanceiro.Transacoes.Transaction

    import ControleFinanceiro.TransacoesFixtures

    @invalid_attrs %{data: nil, descricao: nil, valor: nil, tipo: nil, id_user: nil, data_criacao: nil, data_atualizacao: nil}

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Transacoes.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Transacoes.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      valid_attrs = %{data: ~U[2025-06-06 05:31:00Z], descricao: "some descricao", valor: "120.5", tipo: :"0", id_user: 42, data_criacao: ~U[2025-06-06 05:31:00Z], data_atualizacao: ~U[2025-06-06 05:31:00Z]}

      assert {:ok, %Transaction{} = transaction} = Transacoes.create_transaction(valid_attrs)
      assert transaction.data == ~U[2025-06-06 05:31:00Z]
      assert transaction.descricao == "some descricao"
      assert transaction.valor == Decimal.new("120.5")
      assert transaction.tipo == :"0"
      assert transaction.id_user == 42
      assert transaction.data_criacao == ~U[2025-06-06 05:31:00Z]
      assert transaction.data_atualizacao == ~U[2025-06-06 05:31:00Z]
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transacoes.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      update_attrs = %{data: ~U[2025-06-07 05:31:00Z], descricao: "some updated descricao", valor: "456.7", tipo: :"1", id_user: 43, data_criacao: ~U[2025-06-07 05:31:00Z], data_atualizacao: ~U[2025-06-07 05:31:00Z]}

      assert {:ok, %Transaction{} = transaction} = Transacoes.update_transaction(transaction, update_attrs)
      assert transaction.data == ~U[2025-06-07 05:31:00Z]
      assert transaction.descricao == "some updated descricao"
      assert transaction.valor == Decimal.new("456.7")
      assert transaction.tipo == :"1"
      assert transaction.id_user == 43
      assert transaction.data_criacao == ~U[2025-06-07 05:31:00Z]
      assert transaction.data_atualizacao == ~U[2025-06-07 05:31:00Z]
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Transacoes.update_transaction(transaction, @invalid_attrs)
      assert transaction == Transacoes.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Transacoes.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Transacoes.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Transacoes.change_transaction(transaction)
    end
  end
end
