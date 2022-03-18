# Brotlex

[![CI](https://github.com/hwuethrich/brotlex/actions/workflows/ci.yml/badge.svg)](https://github.com/hwuethrich/brotlex/actions/workflows/ci.yml)

Elixir wrapper for [rust-brotli](https://github.com/dropbox/rust-brotli) using [rustler](https://github.com/rusterlium/rustler) NIFs.

> **Disclaimer:** This is a clone of https://gitlab.com/normanganderson/brotlex with updates for latest rustler and precompiled NIFs. GitHub Actions copied from [html5ever_elixir](https://github.com/rusterlium/html5ever_elixir).

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `brotlex` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:brotlex, github: "hwuethrich/brotlex", tag: "v0.4.0"}
  ]
end
```

By default **you don't need Rust installed** because the lib will try to download
a precompiled NIF file. In case you want to force compilation set the
`BROTLEX_BUILD` environment variable to `true` or `1`. Alternatively you can also set the
application env `:build_from_source` to `true` in order to force the build:

```elixir
config :brotlex, Brotlex, build_from_source: true
```

## Usage

```elixir
iex> {:ok, data} = Brotlex.compress("Hello World")
{:ok, <<11, 5, 128, 72, 101, 108, 108, 111, 32, 87, 111, 114, 108, 100, 3>>}

iex> Brotlex.decompress(data)
{:ok, "Hello World"}
```

You can use this in to compress arbitrary binaries by doing `Brotlex.compress(arbitrary_binary)`. You can then decompress with `Brotlex.decompress(arbitrary_compressed_data)`. The error handling is probably a bit iffy if you try to decompress something that isn't a brotli compressed binary. 

## Benchmarks

You can run some benchmarks between Brotlex and [brotli](https://hex.pm/packages/brotli), by running the following command `MIX_ENV=bench mix run bench/run.exs`. This will compile Brotlex in release mode and compress things with the defaults for both packages.

I'm definitely just discovering how to use Rustler and Elixir together. If you have any ideas on how to make the Rust or Elixir code better please feel free to post issues to the repo.

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/brotlex](https://hexdocs.pm/brotlex).

