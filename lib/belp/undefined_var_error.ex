defmodule Belp.UndefinedVarError do
  defexception [:var]

  def message(exception) do
    "Undefined var: #{exception.var}"
  end
end
