defmodule Brotlex.MixProject do
  use Mix.Project

  @version "0.4.0"
  @repo_url "https://github.com/hwuethrich/brotlex"

  def project do
    [
      app: :brotlex,
      version: @version,
      elixir: "~> 1.12",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      description: "Rustler nif to do brotli compression",
      deps: deps(),
      docs: docs(),
      package: package(),
      compilers: Mix.compilers()
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
      {:benchee, "~> 1.1.0", only: :bench},
      {:benchee_json, "~> 1.0.0", only: :bench},
      {:benchee_html, "~> 1.0.0", only: :bench},
      {:brotli, "~> 0.2", only: [:bench, :test]},
      {:ex_doc, ">= 0.0.0", only: :dev},
      {:rustler_precompiled, "~> 0.2.0"},
      {:stream_data, "~>0.4", only: [:bench, :test]}
    ]
  end

  defp docs do
    [
      main: "Brotlex",
      extras: [],
      source_ref: "v#{@version}",
      source_url: @repo_url
    ]
  end

  defp package do
    [
      files: [
        "lib",
        "native",
        "mix.exs",
        "LICENSE",
        "README.md"
      ],
      maintainers: ["Norm Anderson", "Hannes Wüthrich"],
      licenses: ["MIT"],
      links: %{
        "GitLab" => "https://gitlab.com/normanganderson/brotlex",
        "GitHub" => @repo_url
      }
    ]
  end
end
