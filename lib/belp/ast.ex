defmodule Belp.AST do
  @moduledoc false

  alias Belp.UndefinedVarError

  def eval({:binary_expr, type, a, b}, vars) do
    with {:ok, a} <- eval(a, vars),
         {:ok, b} <- eval(b, vars) do
      {:ok, binary_expr(type, a, b)}
    end
  end

  def eval({:unary_expr, :not_op, a}, vars) do
    with {:ok, a} <- eval(a, vars) do
      {:ok, !a}
    end
  end

  def eval({:var, var}, vars) do
    case Map.fetch(vars, var) do
      {:ok, value} -> {:ok, value}
      :error -> {:error, %UndefinedVarError{var: var}}
    end
  end

  def eval(a, _vars), do: {:ok, a}

  defp binary_expr({:eq_op, :=}, a, b), do: a == b
  defp binary_expr({:eq_op, :!=}, a, b), do: a != b
  defp binary_expr(:and_op, a, b), do: a && b
  defp binary_expr(:or_op, a, b), do: a || b
end
