defmodule ControleFinanceiro.Repo.Migrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :nome, :string
      add :email, :string
      add :senha, :string
      add :data_criacao, :utc_datetime
      add :data_atualizacao, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
