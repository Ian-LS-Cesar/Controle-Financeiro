defmodule ControleFinanceiro.Usuarios.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :nome, :string
    field :email, :string
    field :senha, :string
    field :data_criacao, :utc_datetime
    field :data_atualizacao, :utc_datetime

    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:nome, :email, :senha, :data_criacao, :data_atualizacao])
    |> validate_required([:nome, :email, :senha, :data_criacao, :data_atualizacao])
  end
end
