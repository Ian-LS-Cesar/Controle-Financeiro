defmodule ControleFinanceiro.Categorias.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :nome, :string
    field :data_criacao, :utc_datetime
    field :data_atualizacao, :utc_datetime

    belongs_to :user, ControleFinanceiro.Usuarios.User, foreign_key: :id_user

    many_to_many :transactions, ControleFinanceiro.Transacoes.Transaction,
      join_through: "transaction_tags",
      join_keys: [id_transaction: :id, id_tag: :id]

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:nome, :id_user, :data_criacao, :data_atualizacao])
    |> validate_required([:nome, :id_user])
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
