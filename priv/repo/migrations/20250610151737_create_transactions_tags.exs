defmodule ControleFinanceiro.Repo.Migrations.CreateTransactionsTags do
  use Ecto.Migration

  def change do
    create table(:transactions_tags) do
      add :id_transaction, references(:transactions, on_delete: :nothing)
      add :id_tag, references(:tags, on_delete: :nothing)
      
      timestamps(type: :utc_datetime)
    end

    create index(:transactions_tags, [:id_transaction])
    create index(:transactions_tags, [:id_tag])
  end
end
