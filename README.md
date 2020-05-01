# Belp

[![Build Status](https://travis-ci.org/tlux/belp.svg?branch=master)](https://travis-ci.org/tlux/belp)
[![Coverage Status](https://coveralls.io/repos/github/tlux/belp/badge.svg?branch=master)](https://coveralls.io/github/tlux/belp?branch=master)
[![Hex.pm](https://img.shields.io/hexpm/v/belp.svg)](https://hex.pm/packages/belp)

A simple *B*oolean *E*xpression *L*exer and *P*arser written in Elixir.

## Installation

The package can be installed by adding `belp` to your list of dependencies in
`mix.exs`:

```elixir
def deps do
  [
    {:belp, "~> 0.1"}
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
