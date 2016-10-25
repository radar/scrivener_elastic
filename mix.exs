defmodule ScrivenerElastic.Mixfile do
  use Mix.Project

  def project do
    [app: :scrivener_elastic,
     version: "0.1.0",
     elixir: "~> 1.3",
     elixirc_paths: elixirc_paths(Mix.env),
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
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
      {:elastic, path: "~/code/elixir/elastic"}
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]
end
