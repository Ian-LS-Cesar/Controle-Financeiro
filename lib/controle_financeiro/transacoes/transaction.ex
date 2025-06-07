defmodule ControleFinanceiro.Transacoes.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :data, :utc_datetime
    field :descricao, :string
    field :valor, :decimal
    field :tipo, Ecto.Enum, values: [:"0", :"1"]
    field :data_criacao, :utc_datetime
    field :data_atualizacao, :utc_datetime

    belongs_to :user, ControleFinanceiro.Usuarios.User, foreign_key: :id_user
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:descricao, :valor, :tipo, :data, :id_user, :data_criacao, :data_atualizacao])
    |> validate_required([:descricao, :valor, :tipo, :data, :id_user, :data_criacao, :data_atualizacao])
  end
end
