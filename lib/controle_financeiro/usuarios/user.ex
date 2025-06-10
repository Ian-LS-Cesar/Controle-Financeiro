defmodule ControleFinanceiro.Usuarios.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :nome, :string
    field :email, :string
    field :senha, :string
    field :data_criacao, :utc_datetime
    field :data_atualizacao, :utc_datetime

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
    |> put_data_criacao()
    |> put_data_atualizacao()
  end

  defp put_senha_hash(%Ecto.Changeset{valid?: true, changes: %{senha: senha}} = changeset) do
    change(changeset, senha: Bcrypt.hash_pwd_salt(senha))
  end
  defp put_senha_hash(changeset), do: changeset

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
