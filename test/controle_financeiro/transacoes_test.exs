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

  describe "transactions_tags" do
    alias ControleFinanceiro.Transacoes.TransactionsTag

    import ControleFinanceiro.TransacoesFixtures

    @invalid_attrs %{}

    test "list_transactions_tags/0 returns all transactions_tags" do
      transactions_tag = transactions_tag_fixture()
      assert Transacoes.list_transactions_tags() == [transactions_tag]
    end

    test "get_transactions_tag!/1 returns the transactions_tag with given id" do
      transactions_tag = transactions_tag_fixture()
      assert Transacoes.get_transactions_tag!(transactions_tag.id) == transactions_tag
    end

    test "create_transactions_tag/1 with valid data creates a transactions_tag" do
      valid_attrs = %{}

      assert {:ok, %TransactionsTag{} = transactions_tag} = Transacoes.create_transactions_tag(valid_attrs)
    end

    test "create_transactions_tag/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Transacoes.create_transactions_tag(@invalid_attrs)
    end

    test "update_transactions_tag/2 with valid data updates the transactions_tag" do
      transactions_tag = transactions_tag_fixture()
      update_attrs = %{}

      assert {:ok, %TransactionsTag{} = transactions_tag} = Transacoes.update_transactions_tag(transactions_tag, update_attrs)
    end

    test "update_transactions_tag/2 with invalid data returns error changeset" do
      transactions_tag = transactions_tag_fixture()
      assert {:error, %Ecto.Changeset{}} = Transacoes.update_transactions_tag(transactions_tag, @invalid_attrs)
      assert transactions_tag == Transacoes.get_transactions_tag!(transactions_tag.id)
    end

    test "delete_transactions_tag/1 deletes the transactions_tag" do
      transactions_tag = transactions_tag_fixture()
      assert {:ok, %TransactionsTag{}} = Transacoes.delete_transactions_tag(transactions_tag)
      assert_raise Ecto.NoResultsError, fn -> Transacoes.get_transactions_tag!(transactions_tag.id) end
    end

    test "change_transactions_tag/1 returns a transactions_tag changeset" do
      transactions_tag = transactions_tag_fixture()
      assert %Ecto.Changeset{} = Transacoes.change_transactions_tag(transactions_tag)
    end
  end
end
