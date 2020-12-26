# Identicon

Library to create [identicons](https://en.wikipedia.org/wiki/Identicon)
developed while learning Elixir.

## Usage

We can create an identicon given a string. For example the snippet below
produces the following identicon image.

```elixir
Identicon.main("davide")
```

![davide-identicon](docs/davide-identicon.png)

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `identicon` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:identicon, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/identicon](https://hexdocs.pm/identicon).
