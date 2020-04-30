defmodule Belp.UndefinedVariableError do
  @moduledoc """
  An error that is returned or raised when a variable used in a expression is
  undefined.
  """

  defexception [:var]

  @type t :: %__MODULE__{var: String.t()}

  def message(exception) do
    "Undefined variable: #{exception.var}"
  end
end
