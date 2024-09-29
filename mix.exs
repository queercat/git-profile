defmodule GitProfile.MixProject do
  use Mix.Project

  def project do
    [
      app: :git_profilegit_profile,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      escript: [main_module: GitProfile, name: :gitp]
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
      # {:dep_from_hexpm, "~> 0.3.0"},
      # {:dep_from_git, git: "https://github.com/elixir-lang/my_dep.git", tag: "0.1.0"}
      {:yaml_elixir, "~> 2.11"},
      {:ymlr, "~> 5.1"}
    ]
  end
end
