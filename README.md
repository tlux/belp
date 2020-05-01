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
iex> Belp.eval("foo and bar", foo: true, bar: false)
{:ok, true}

iex> Belp.eval!(
...>   "(foo or bar) and not baz",
...>   %{"foo" => false, "bar" => true, "baz" => true}
...> )
false

iex> Belp.variables("foo or bar")
{:ok, ["foo", "bar"]}

iex> Belp.variables!("foo or bar")
["foo", "bar"]
```

See [HexDocs](https://hexdocs.pm/belp) for the full API.
