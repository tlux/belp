defmodule Belp.InvalidCharError do
  @moduledoc """
  An error that is returned or raised when a expression contains an invalid
  char.
  """

  defexception [:char, :line]

  @type t :: %__MODULE__{
          char: String.t(),
          line: pos_integer
        }

  def message(exception) do
    "Invalid character #{inspect(exception.char)} on line #{exception.line}"
  end
end
