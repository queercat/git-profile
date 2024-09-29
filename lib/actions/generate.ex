defmodule Actions.Generate do
  def generate_profile(profile_name, global \\ false) do
    name = System.cmd("git", ["config", "user.name"]) |> catch_fire()
    email = System.cmd("git", ["config", "user.email"]) |> catch_fire()

    Actions.New.new_profile(profile_name, name, email, global)

    nil
  end

  defp catch_fire({value, 0}), do: String.replace(value, "\n", "")

  defp catch_fire({_, status}) do
    IO.puts("Unable to generate profile!")
    System.halt(status)
  end
end
