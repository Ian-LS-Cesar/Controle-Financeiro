defmodule ControleFinanceiro.Usuarios.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :nome, :string
    field :email, :string
    field :senha, :string
    field :data_criacao, :utc_datetime
    field :data_atualizacao, :utc_datetime

    has_many :transactions, ControleFinanceiro.Usuarios.User, foreign_key: :id_user
    has_many :tags, ControleFinanceiro.Usuarios.User, foreign_key: :id_user
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do

    user
    |> cast(attrs, [:nome, :email, :senha, :data_criacao, :data_atualizacao])
    |> validate_required([:nome, :email, :senha, :data_criacao, :data_atualizacao])
    |> unique_constraint(:email)
  # |> put_senha_hash
  end

  # defp put_senha_hash(%Ecto.Changeset{valid?: true, changes: %{hash_senha: hash_senha}} = changeset) do
  #   change(changeset, hash_senha: BCrypt.hash_pwd_salt(hash_senha))
  # end

  # defp put_senha_hash(changeset) do: changeset
end
