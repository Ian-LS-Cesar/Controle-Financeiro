defmodule ControleFinanceiro.Categorias.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :nome, :string
    field :data_criacao, :utc_datetime
    field :data_atualizacao, :utc_datetime

    belongs_to :user, ControleFinanceiro.Usuarios.User, foreign_key: :id_user
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag, attrs) do

    tag
    |> cast(attrs, [:nome, :id_user, :data_criacao, :data_atualizacao])
    |> validate_required([:nome, :id_user, :data_criacao, :data_atualizacao])
  end
end
