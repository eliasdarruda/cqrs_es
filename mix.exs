defmodule CqrsEs.MixProject do
  use Mix.Project

  def project do
    [
      app: :cqrs_es,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      mod: {CqrsEs.Application, []},
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:phoenix_pubsub, "~> 2.0"},
      {:eventstore, "~> 1.3"},
      {:jason, "~> 1.2"}
    ]
  end
end
