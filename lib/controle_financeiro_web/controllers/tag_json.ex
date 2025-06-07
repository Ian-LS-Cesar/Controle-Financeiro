defmodule ControleFinanceiroWeb.TagJSON do
  alias ControleFinanceiro.Categorias.Tag

  @doc """
  Renders a list of tags.
  """
  def index(%{tags: tags}) do
    %{data: for(tag <- tags, do: data(tag))}
  end

  @doc """
  Renders a single tag.
  """
  def show(%{tag: tag}) do
    %{data: data(tag)}
  end

  defp data(%Tag{} = tag) do
    %{
      id: tag.id,
      nome: tag.nome,
      id_user: tag.id_user,
      data_criacao: tag.data_criacao,
      data_atualizacao: tag.data_atualizacao
    }
  end
end
