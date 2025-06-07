defmodule ControleFinanceiro.TransacoesFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ControleFinanceiro.Transacoes` context.
  """

  @doc """
  Generate a transaction.
  """
  def transaction_fixture(attrs \\ %{}) do
    {:ok, transaction} =
      attrs
      |> Enum.into(%{
        data: ~U[2025-06-06 05:31:00Z],
        data_atualizacao: ~U[2025-06-06 05:31:00Z],
        data_criacao: ~U[2025-06-06 05:31:00Z],
        descricao: "some descricao",
        id_user: 42,
        tipo: :"0",
        valor: "120.5"
      })
      |> ControleFinanceiro.Transacoes.create_transaction()

    transaction
  end
end
