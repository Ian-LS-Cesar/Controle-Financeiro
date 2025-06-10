defmodule ControleFinanceiro.Transacoes.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :data, :utc_datetime
    field :descricao, :string
    field :valor, :decimal
    field :tipo, Ecto.Enum, values: [:"0", :"1"]

    belongs_to :user, ControleFinanceiro.Usuarios.User, foreign_key: :id_user

    many_to_many :tags, ControleFinanceiro.Categorias.Tag,
    join_through: ControleFinanceiro.Transacoes.TransactionsTag,
    join_keys: [id_transaction: :id, id_tag: :id],
    on_replace: :delete

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
  transaction
  |> cast(attrs, [:descricao, :valor, :tipo, :data, :id_user])
  |> validate_required([:descricao, :valor, :tipo, :data, :id_user])
end

end
