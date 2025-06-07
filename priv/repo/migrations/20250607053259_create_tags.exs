defmodule ControleFinanceiro.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :nome, :string
      add :data_criacao, :utc_datetime
      add :data_atualizacao, :utc_datetime
      add :id_user, references(:users, on_delete: :delete_all)
      timestamps(type: :utc_datetime)
    end
  end
end
