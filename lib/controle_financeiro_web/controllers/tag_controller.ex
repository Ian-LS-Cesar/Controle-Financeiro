defmodule ControleFinanceiroWeb.TagController do
  use ControleFinanceiroWeb, :controller

  alias ControleFinanceiro.Categorias
  alias ControleFinanceiro.Categorias.Tag

  action_fallback ControleFinanceiroWeb.FallbackController

  def index(conn, _params) do
    tags = Categorias.list_tags()
    render(conn, :index, tags: tags)
  end

  def create(conn, %{"tag" => tag_params}) do
    with {:ok, %Tag{} = tag} <- Categorias.create_tag(tag_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/tags/#{tag}")
      |> render(:show, tag: tag)
    end
  end

  def show(conn, %{"id" => id}) do
    tag = Categorias.get_tag!(id)
    render(conn, :show, tag: tag)
  end

  def update(conn, %{"id" => id, "tag" => tag_params}) do
    tag = Categorias.get_tag!(id)

    with {:ok, %Tag{} = tag} <- Categorias.update_tag(tag, tag_params) do
      render(conn, :show, tag: tag)
    end
  end

  def delete(conn, %{"id" => id}) do
    tag = Categorias.get_tag!(id)

    with {:ok, %Tag{}} <- Categorias.delete_tag(tag) do
      send_resp(conn, :no_content, "")
    end
  end
end
