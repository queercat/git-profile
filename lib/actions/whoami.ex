defmodule Actions.Whoami do
  def whoami do
    name = System.cmd("git", ["config", "user.name"]) |> catch_fire()
    email = System.cmd("git", ["config", "user.email"]) |> catch_fire()

    IO.puts("Your name: #{name} and your email: #{email}.")
  end

  defp catch_fire({value, 0}), do: String.replace(value, "\n", "")

  defp catch_fire({_, status}) do
    IO.puts("Unable to generate profile!")
    System.halt(status)
  end
end
