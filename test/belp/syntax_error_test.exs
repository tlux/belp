defmodule Belp.SyntaxErrorTest do
  use ExUnit.Case, async: true

  alias Belp.SyntaxError

  describe "message/1" do
    test "get message" do
      assert Exception.message(%SyntaxError{line: 63, token: "Foo"}) ==
               ~s(Syntax error near token "Foo" on line 63)
    end
  end
end
