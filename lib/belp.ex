defmodule Belp do
  @moduledoc """
  Belp is a simple Boolean Expression Lexer and Parser.
  """

  alias Belp.{AST, InvalidCharError, SyntaxError, UndefinedVariableError}

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
        ) ::
          {:ok, boolean}
          | {:error,
             InvalidCharError.t() | SyntaxError.t() | UndefinedVariableError.t()}
  def eval(expr, vars \\ %{}) do
    with {:ok, _tokens, ast} <- parse(expr) do
      AST.eval(ast, sanitize_vars(vars))
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
    expr |> eval(vars) |> may_bang!()
  end

  @doc """
  Checks whether the given expression is valid.
  """
  @spec valid_expression?(expr) :: boolean
  def valid_expression?(expr) do
    match?({:ok, _, _}, parse(expr))
  end

  @doc """
  Gets a list of variable names that are present in the given expression.
  """
  @spec variables(expr) ::
          {:ok, [String.t()]}
          | {:error, InvalidCharError.t() | SyntaxError.t()}
  def variables(expr) do
    with {:ok, tokens, _ast} <- parse(expr) do
      vars =
        for token <- tokens,
            match?({:var, _, _}, token),
            {:var, _, var} = token,
            uniq: true,
            do: var

      {:ok, vars}
    end
  end

  @doc """
  Gets a list of variable names that are present in the given expression. Raises
  when the expression is invalid or variables are undefined.
  """
  @spec variables!(expr) :: [String.t()] | no_return
  def variables!(expr) do
    expr |> variables() |> may_bang!()
  end

  defp lex(expr) do
    case :belp_lexer.string(to_charlist(expr)) do
      {:ok, tokens, _lines} ->
        {:ok, tokens}

      {:error, {line, _, {:illegal, char}}, _lines} ->
        {:error, %InvalidCharError{char: to_string(char), line: line}}
    end
  end

  defp may_bang!({:ok, value}), do: value
  defp may_bang!({:error, error}), do: raise(error)

  defp parse(expr) do
    with {:ok, tokens} <- lex(expr),
         {:ok, ast} <- do_parse(tokens) do
      {:ok, tokens, ast}
    end
  end

  defp do_parse(tokens) do
    case :belp_parser.parse(tokens) do
      {:ok, ast} ->
        {:ok, ast}

      {:error, {line, _, [_, token]}} ->
        {:error, %SyntaxError{line: line, token: to_string(token)}}
    end
  end

  defp sanitize_vars(vars) do
    Map.new(vars, fn {key, value} -> {to_string(key), !!value} end)
  end
end
