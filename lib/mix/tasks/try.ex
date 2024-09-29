defmodule Mix.Tasks.Try do
  use Mix.Task

  def run(argv) do
    GitProfile.main(argv)
  end
end
