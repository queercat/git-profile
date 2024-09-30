defmodule Actions.Generate do
  def generate_profile(profile_name, global \\ false) do
    name =
      System.cmd("git", Enum.filter(["config", format_global(global), "user.name"], &(&1 != nil)))
      |> catch_fire()

    email =
      System.cmd(
        "git",
        Enum.filter(["config", format_global(global), "user.email"], &(&1 != nil))
      )
      |> catch_fire()

    Actions.New.new_profile(profile_name, email, name, global)

    nil
  end

  defp format_global(true), do: "--global"

  defp format_global(_), do: nil

  defp catch_fire({value, 0}), do: String.replace(value, "\n", "")

  defp catch_fire({_, status}) do
    IO.puts("Unable to generate profile!")
    System.halt(status)
  end
end
