defmodule ControleFinanceiro.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :descricao, :string
      add :valor, :decimal
      add :tipo, :string
      add :data, :utc_datetime
      add :data_criacao, :utc_datetime
      add :data_atualizacao, :utc_datetime
      add :id_user, references(:users, on_delete: :delete_all)
      timestamps(type: :utc_datetime)
    end
  end
end
