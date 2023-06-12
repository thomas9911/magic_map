defmodule MagicMap.MixProject do
  use Mix.Project

  def project do
    [
      app: :magic_map,
      version: "0.1.0",
      elixir: "~> 1.13",
      start_permanent: Mix.env() == :prod,
      deps: deps()
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
      {:styler, "~> 0.7", only: [:dev, :test], runtime: false}
    ]
  end
end
