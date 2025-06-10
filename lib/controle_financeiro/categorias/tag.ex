defmodule ControleFinanceiro.Categorias.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :nome, :string

    belongs_to :user, ControleFinanceiro.Usuarios.User, foreign_key: :id_user

    many_to_many :transactions, ControleFinanceiro.Transacoes.Transaction,
      join_through: "transaction_tags",
      join_keys: [id_transaction: :id, id_tag: :id]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:nome, :id_user])
    |> validate_required([:nome, :id_user])
  end
end
