defmodule ControleFinanceiro.UsuariosFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `ControleFinanceiro.Usuarios` context.
  """

  @doc """
  Generate a user.
  """
  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        data_atualizacao: ~U[2025-06-06 05:27:00Z],
        data_criacao: ~U[2025-06-06 05:27:00Z],
        email: "some email",
        nome: "some nome",
        senha: "some senha"
      })
      |> ControleFinanceiro.Usuarios.create_user()

    user
  end
end
