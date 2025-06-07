defmodule ControleFinanceiro.CategoriasFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ControleFinanceiro.Categorias` context.
  """

  @doc """
  Generate a tag.
  """
  def tag_fixture(attrs \\ %{}) do
    {:ok, tag} =
      attrs
      |> Enum.into(%{
        data_atualizacao: ~U[2025-06-06 05:32:00Z],
        data_criacao: ~U[2025-06-06 05:32:00Z],
        id_user: 42,
        nome: "some nome"
      })
      |> ControleFinanceiro.Categorias.create_tag()

    tag
  end
end
