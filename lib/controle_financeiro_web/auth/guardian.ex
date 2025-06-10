defmodule ControleFinanceiroWeb.Auth.Guardian do
  use Guardian, otp_app: :controle_financeiro
  alias ControleFinanceiro.Usuarios

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def subject_for_token(_, _) do
    {:error, :no_id_provided}
  end

  def resource_from_claims(%{"sub" => id}) do
    case Usuarios.get_user!(id) do
      nil -> {:error, :not_found}
      resource -> {:ok, resource}
    end
  end

  def resource_from_claims(_claims) do
    {:error, :no_id_provided}
  end

  def authenticate(email, senha) do
    case Usuarios.get_user_by_email(email) do
      nil -> {:error, :unauthorized}
      user ->
        case validate_senha(senha, user.hash_senha) do
          true -> create_token(user)
          false -> {:error, :unauthorized}
        end
    end
  end

  defp validate_senha(senha, hash_senha) do
    Bcrypt.verify_pass(senha, hash_senha)
  end

  defp create_token(user) do
    {:ok, token, _claims} = encode_and_sign(user)
    {:ok, user, token}
  end
end
