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
  many_to_many :tags, ControleFinanceiro.Categorias.Tag,
    join_through: "transactions_tags",
    join_keys: [id_transaction: :id, id_tag: :id]
  timestamps(type: :utc_datetime)
end

  @doc false
  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:descricao, :valor, :tipo, :data, :id_user, :data_criacao, :data_atualizacao])
    |> validate_required([:descricao, :valor, :tipo, :data, :id_user])
    |> put_data_criacao()
    |> put_data_atualizacao()
  end

  defp put_data_criacao(%Ecto.Changeset{data: %{id: nil}} = changeset) do
    now = DateTime.utc_now() |> DateTime.truncate(:second)
    put_change(changeset, :data_criacao, now)
  end

  defp put_data_criacao(changeset), do: changeset

  defp put_data_atualizacao(changeset) do
    now = DateTime.utc_now() |> DateTime.truncate(:second)
    put_change(changeset, :data_atualizacao, now)
  end
end
