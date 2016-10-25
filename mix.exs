defmodule ScrivenerElastic.Mixfile do
  use Mix.Project

  def project do
    [app: :scrivener_elastic,
     version: "1.0.0",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger, :elastic]]
  end

  defp deps do
    [
      {:scrivener, "~> 2.0"},
      {:elastic, "~> 2.2"},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    [
      name: :scrivener_elastic,
      description: "Scrivener integration for Elastic",
      files: ["lib", "README*", "mix.exs"],
      maintainers: ["Ryan Bigg"],
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/radar/scrivener_elastic"}
    ]
  end
end
