defmodule ControleFinanceiro.Usuarios.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :nome, :string
    field :email, :string
    field :senha, :string

    has_many :transactions, ControleFinanceiro.Transacoes.Transaction, foreign_key: :id_user
    has_many :tags, ControleFinanceiro.Categorias.Tag, foreign_key: :id_user
    timestamps(type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:nome, :email, :senha, :data_criacao, :data_atualizacao])
    |> validate_required([:nome, :email, :senha])
    |> unique_constraint(:email)
    |> put_senha_hash()
  end

  defp put_senha_hash(%Ecto.Changeset{valid?: true, changes: %{senha: senha}} = changeset) do
    change(changeset, senha: Bcrypt.hash_pwd_salt(senha))
  end
  defp put_senha_hash(changeset), do: changeset
end
