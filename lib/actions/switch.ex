defmodule Actions.Switch do
  import Utilities

  def switch_profile(profile_name, global \\ false) do
    case parse_profiles() |> Map.get(profile_name) do
      nil ->
        IO.puts("Profile #{profile_name} not found!")
        System.halt(1)

      [%{"email" => email}, %{"name" => name}] ->
        System.cmd(
          "git",
          Enum.filter(["config", format_global(global), "user.email", "#{email}"], &(&1 != nil))
        )
        |> catch_fire()

        System.cmd(
          "git",
          Enum.filter(["config", format_global(global), "user.name", "#{name}"], &(&1 != nil))
        )
        |> catch_fire()

        IO.puts("Profile changed to #{profile_name}")
    end

    nil
  end

  defp format_global(true), do: "--global"
  defp format_global(_), do: nil

  defp catch_fire({_, status}) do
    case status do
      0 ->
        nil

      _ ->
        IO.puts("Unable to switch profile!")
        System.halt(status)
    end
  end
end
