defmodule Belp.UndefinedVariableErrorTest do
  use ExUnit.Case, async: true

  alias Belp.UndefinedVariableError

  describe "message/1" do
    test "get message" do
      assert Exception.message(%UndefinedVariableError{var: "foo"}) ==
               ~s(Undefined variable: foo)
    end
  end
end
