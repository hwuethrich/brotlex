# Brotlex

[![CI](https://github.com/hwuethrich/brotlex/actions/workflows/ci.yml/badge.svg)](https://github.com/hwuethrich/brotlex/actions/workflows/ci.yml)

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `brotlex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:brotlex, "~> 0.2"}
  ]
end
```

You can run some benchmarks between Brotlex and [brotli](https://hex.pm/packages/brotli), by running the following command `MIX_ENV=bench mix run bench/run.exs`. This will compile Brotlex in release mode and compress things with the defaults for both packages.

You can use this in to compress arbitrary binaries by doing `Brotlex.compress(arbitrary_binary)`. You can then decompress with `Brotlex.decompress(arbitrary_compressed_data)`. The error handling is probably a bit iffy if you try to decompress something that isn't a brotli compressed binary. 

I'm definitely just discovering how to use Rustler and Elixir together. If you have any ideas on how to make the Rust or Elixir code better please feel free to post issues to the repo.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/brotlex](https://hexdocs.pm/brotlex).

