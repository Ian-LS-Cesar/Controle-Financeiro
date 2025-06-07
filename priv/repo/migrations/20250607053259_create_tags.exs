defmodule ControleFinanceiro.Repo.Migrations.CreateTags do
  use Ecto.Migration

  def change do
    create table(:tags) do
      add :nome, :string
      add :id_user, :integer
      add :data_criacao, :utc_datetime
      add :data_atualizacao, :utc_datetime

      timestamps(type: :utc_datetime)
    end
  end
end
