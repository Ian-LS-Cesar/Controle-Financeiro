defmodule ControleFinanceiro.Transacoes.TransactionsTag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions_tags" do

    field :id_transaction, :id
    field :id_tag, :id

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transactions_tag, attrs) do
    transactions_tag
    |> cast(attrs, [])
    |> validate_required([])
  end
end
