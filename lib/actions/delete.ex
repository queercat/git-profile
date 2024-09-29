defmodule Actions.Delete do
  import Utilities

  def delete_profile(profile_name) do
    profiles = parse_profiles()

    case profiles[profile_name] do
      nil ->
        IO.puts("Profile #{profile_name} not found!")

      _ ->
        case prompt("Are you sure you want to delete profile #{profile_name}? [Y/n]")
             |> String.downcase() do
          "n" ->
            IO.puts("Delete cancelled!")
            nil

          _ ->
            Map.delete(profiles, profile_name) |> save_profiles()
            IO.puts("Profile #{profile_name} deleted!")

            IO.puts(
              "(This may still be your active profile, don't forget to switch if you want to do that.)"
            )
        end
    end
  end
end
