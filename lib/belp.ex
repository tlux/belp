defmodule Belp do
  @moduledoc """
  Belp is a simple Boolean Expression Lexer and Parser.
  """

  alias Belp.AST

  @typedoc """
  A type that describes which primitives can be used as expression.
  """
  @type expr :: String.t() | charlist

  @doc """
  Evaluates the given expression.
  """
  @spec eval(
          expr,
          Keyword.t(as_boolean(any))
          | %{optional(atom | String.t()) => as_boolean(any)}
        ) :: {:ok, boolean} | {:error, any}
  def eval(expr, vars \\ %{}) do
    with {:ok, tree} <- parse(expr) do
      AST.eval(tree, sanitize_vars(vars))
    end
  end

  @doc """
  Evaluates the given expression. Raises when the expression is invalid or
  variables are undefined.
  """
  @spec eval!(
          expr,
          Keyword.t(as_boolean(any))
          | %{optional(atom | String.t()) => as_boolean(any)}
        ) :: boolean | no_return
  def eval!(expr, vars \\ %{}) do
    case eval(expr, vars) do
      {:ok, value} -> value
      {:error, error} -> raise error
    end
  end

  @doc """
  Gets a list of variable names that are present in the given expression.
  """
  @spec vars(expr) :: {:ok, [String.t()]} | :error
  def vars(expr) do
    case lex(expr) do
      {:ok, tokens} ->
        vars =
          for token <- tokens,
              match?({:var, _, _}, token),
              {:var, _, var} = token,
              uniq: true,
              do: var

        {:ok, vars}

      _ ->
        :error
    end
  end

  defp lex(expr) do
    case :belp_lexer.string(to_charlist(expr)) do
      {:ok, tokens, _lines} -> {:ok, tokens}
      _ -> :error
    end
  end

  defp parse(expr) do
    with {:ok, tokens} <- lex(expr) do
      :belp_parser.parse(tokens)
    end
  end

  defp sanitize_vars(vars) do
    Map.new(vars, fn {key, value} -> {to_string(key), !!value} end)
  end
end
