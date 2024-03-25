# Belp

[![Build](https://github.com/tlux/belp/actions/workflows/elixir.yml/badge.svg)](https://github.com/tlux/belp/actions/workflows/elixir.yml)
[![Coverage Status](https://coveralls.io/repos/github/tlux/belp/badge.svg?branch=main)](https://coveralls.io/github/tlux/belp?branch=main)
[![Module Version](https://img.shields.io/hexpm/v/vx.svg)](https://hex.pm/packages/vx)
[![Hex Docs](https://img.shields.io/badge/hex-docs-lightgreen.svg)](https://hexdocs.pm/vx/)
[![License](https://img.shields.io/hexpm/l/vx.svg)](https://github.com/tlux/belp/blob/main/LICENSE.md)
[![Last Updated](https://img.shields.io/github/last-commit/tlux/belp.svg)](https://github.com/tlux/belp/commits/main)

A simple *B*oolean *E*xpression *L*exer and *P*arser written in Elixir.

## Installation

The package can be installed by adding `belp` to your list of dependencies in
`mix.exs`:

```elixir
def deps do
  [
    {:belp, "~> 0.3"}
  ]
end
```

## Usage

```elixir
iex> Belp.eval!(
...>   "(foo or bar) and not baz",
...>   %{"foo" => false, "bar" => true, "baz" => false}
...> )
true
```

```elixir
iex> Belp.eval!("invalid expression")
** (Belp.SyntaxError) Syntax error near token "expression" on line 1
```

See [HexDocs](https://hexdocs.pm/belp) for the full API.
