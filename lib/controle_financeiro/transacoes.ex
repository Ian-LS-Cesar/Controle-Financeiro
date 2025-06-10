defmodule ControleFinanceiro.Transacoes do
  @moduledoc """
  The Transacoes context.
  """

  import Ecto.Query, warn: false
  alias ControleFinanceiro.Repo

  alias ControleFinanceiro.Transacoes.Transaction

  @doc """
  Returns the list of transactions.

  ## Examples

      iex> list_transactions()
      [%Transaction{}, ...]

  """
  def list_transactions do
    Repo.all(Transaction)
  end

  @doc """
  Gets a single transaction.

  Raises `Ecto.NoResultsError` if the Transaction does not exist.

  ## Examples

      iex> get_transaction!(123)
      %Transaction{}

      iex> get_transaction!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  @doc """
  Creates a transaction.

  ## Examples

      iex> create_transaction(%{field: value})
      {:ok, %Transaction{}}

      iex> create_transaction(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transaction(attrs \\ %{}) do
    %Transaction{}
    |> Transaction.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.

  ## Examples

      iex> update_transaction(transaction, %{field: new_value})
      {:ok, %Transaction{}}

      iex> update_transaction(transaction, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.

  ## Examples

      iex> delete_transaction(transaction)
      {:ok, %Transaction{}}

      iex> delete_transaction(transaction)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.

  ## Examples

      iex> change_transaction(transaction)
      %Ecto.Changeset{data: %Transaction{}}

  """
  def change_transaction(%Transaction{} = transaction, attrs \\ %{}) do
    Transaction.changeset(transaction, attrs)
  end

  alias ControleFinanceiro.Transacoes.TransactionsTag

  @doc """
  Returns the list of transactions_tags.

  ## Examples

      iex> list_transactions_tags()
      [%TransactionsTag{}, ...]

  """
  def list_transactions_tags do
    Repo.all(TransactionsTag)
  end

  @doc """
  Gets a single transactions_tag.

  Raises `Ecto.NoResultsError` if the Transactions tag does not exist.

  ## Examples

      iex> get_transactions_tag!(123)
      %TransactionsTag{}

      iex> get_transactions_tag!(456)
      ** (Ecto.NoResultsError)

  """
  def get_transactions_tag!(id), do: Repo.get!(TransactionsTag, id)

  @doc """
  Creates a transactions_tag.

  ## Examples

      iex> create_transactions_tag(%{field: value})
      {:ok, %TransactionsTag{}}

      iex> create_transactions_tag(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_transactions_tag(attrs \\ %{}) do
    %TransactionsTag{}
    |> TransactionsTag.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a transactions_tag.

  ## Examples

      iex> update_transactions_tag(transactions_tag, %{field: new_value})
      {:ok, %TransactionsTag{}}

      iex> update_transactions_tag(transactions_tag, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_transactions_tag(%TransactionsTag{} = transactions_tag, attrs) do
    transactions_tag
    |> TransactionsTag.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transactions_tag.

  ## Examples

      iex> delete_transactions_tag(transactions_tag)
      {:ok, %TransactionsTag{}}

      iex> delete_transactions_tag(transactions_tag)
      {:error, %Ecto.Changeset{}}

  """
  def delete_transactions_tag(%TransactionsTag{} = transactions_tag) do
    Repo.delete(transactions_tag)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transactions_tag changes.

  ## Examples

      iex> change_transactions_tag(transactions_tag)
      %Ecto.Changeset{data: %TransactionsTag{}}

  """
  def change_transactions_tag(%TransactionsTag{} = transactions_tag, attrs \\ %{}) do
    TransactionsTag.changeset(transactions_tag, attrs)
  end
end
