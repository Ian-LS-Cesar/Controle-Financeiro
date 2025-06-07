defmodule ControleFinanceiro.Categorias.Tag do
  use Ecto.Schema
  import Ecto.Changeset

  schema "tags" do
    field :nome, :string
    field :id_user, :integer
    field :data_criacao, :utc_datetime
    field :data_atualizacao, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(tag, attrs) do
    tag
    |> cast(attrs, [:nome, :id_user, :data_criacao, :data_atualizacao])
    |> validate_required([:nome, :id_user, :data_criacao, :data_atualizacao])
  end
end
