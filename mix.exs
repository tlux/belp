defmodule Belp.MixProject do
  use Mix.Project

  def project do
    [
      app: :belp,
      version: "0.2.2",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      test_coverage: [tool: ExCoveralls],
      compilers: [:yecc, :leex] ++ Mix.compilers(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test,
        "coveralls.travis": :test
      ],
      dialyzer: [plt_add_apps: [:ex_unit, :mix]],
      description: description(),
      package: package(),

      # Docs
      name: "Belp",
      source_url: "https://github.com/tlux/belp",
      docs: [
        main: "readme",
        extras: ["README.md"]
      ]
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: []
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 1.4", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev, :test], runtime: false},
      {:excoveralls, "~> 0.12", only: :test},
      {:ex_doc, "~> 0.21", only: :dev}
    ]
  end

  defp description do
    "A simple Boolean Expression Lexer and Parser."
  end

  defp package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/tlux/belp"
      }
    ]
  end
end
