defmodule Actions.List do
  import Utilities

  def list_profiles do
    parse_profiles() |> list_profiles()
  end

  defp list_profiles(profiles) when map_size(profiles) <= 0 do
    IO.puts("No profiles!")
  end

  defp list_profiles(profiles) do
    [profiles]
    |> Enum.flat_map(&Map.keys/1)
    |> Enum.map(&("- " <> &1))
    |> Enum.join("\n")
    |> IO.puts()
  end
end
