defmodule Belp.SyntaxError do
  @moduledoc """
  An error that is returned or raised when the expression contains a syntax
  error.
  """

  defexception [:line, :token]

  @type t :: %__MODULE__{
          line: pos_integer,
          token: String.t()
        }

  def message(exception) do
    "Syntax error on line #{exception.line} near token " <>
      inspect(exception.token)
  end
end
