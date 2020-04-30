defmodule Belp.InvalidCharErrorTest do
  use ExUnit.Case, async: true

  alias Belp.InvalidCharError

  describe "message/1" do
    test "get message" do
      assert Exception.message(%InvalidCharError{char: "&", line: 7}) ==
               ~s(Invalid character "&" on line 7)
    end
  end
end
