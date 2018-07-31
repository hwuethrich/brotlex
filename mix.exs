defmodule Brotlex.MixProject do
  use Mix.Project

  def project do
    [
      app: :brotlex,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      description: "Rustler nif to do brotli compression",
      deps: deps(),
      package: [
        files: ["lib", "mix.exs", "native"],
        maintainers: ["Norm Anderson"],
        licenses: ["MIT"],
        links: %{"Gitlab" => "https://gitlab.com/normanganderson/brotlex"}
      ],
      compilers: [:rustler] ++ Mix.compilers(),
      rustler_crates: rustler_crates()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:brotli, "~> 0.2", only: :dev},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:rustler, "~> 0.18"}
    ]
  end

  def rustler_crates do
    [
      brotlex: [
        path: "./native/brotlex",
        mode:
          case Mix.env() do
            :prod -> :release
            _ -> :debug
          end
      ]
    ]
  end
end
