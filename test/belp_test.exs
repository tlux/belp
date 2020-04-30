defmodule BelpTest do
  use ExUnit.Case

  describe "eval/1" do
    test "evaluate expression" do
      assert Belp.eval("true") == {:ok, true}
      assert Belp.eval("false") == {:ok, false}
      assert Belp.eval("true and true") == {:ok, true}
      assert Belp.eval("true and false") == {:ok, false}
      assert Belp.eval("true or false") == {:ok, true}
      assert Belp.eval("false or false") == {:ok, false}
      assert Belp.eval("(true and false) or true") == {:ok, true}
      assert Belp.eval("(true and false) or false") == {:ok, false}
      assert Belp.eval("!true") == {:ok, false}
      assert Belp.eval("not true") == {:ok, false}
      assert Belp.eval("!false") == {:ok, true}
      assert Belp.eval("not false") == {:ok, true}
      assert Belp.eval("not (false or true)") == {:ok, false}
      assert Belp.eval("not false or true") == {:ok, true}
    end

    test "error when variable used" do
      assert Belp.eval(expr)
    end
  end

  describe "eval/2" do
    test "evaluate expression"

    test "error when undefined variable used"
  end

  describe "eval!/1" do
    test "evaluate expression"

    test "raise when variable used"
  end

  describe "eval!/2" do
    test "evaluate expression"

    test "raise when undefined variable used"
  end

  describe "vars/1" do
    test "get vars for valid expression" do
      assert Belp.vars("(foo and bar) or (not bar and baz)") ==
               {:ok, ~w(foo bar baz)}
    end

    test "error when expression invalid" do
      assert Belp.vars("foo && bar") == :error
      assert Belp.vars("foo and (bar or foo)") == :error
    end
  end
end
