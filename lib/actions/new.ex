defmodule Actions.New do
  import Utilities

  def new_profile(profile_name, email, name, global \\ false) do
    parse_profiles()
    |> Map.put(profile_name, [%{"email" => email}, %{"name" => name}])
    |> save_profiles()

    IO.puts("Profile #{profile_name} added!")

    case prompt("Would you like to switch now? [N/y]") |> String.downcase() do
      "y" -> Actions.Switch.switch_profile(profile_name, global)
      _ -> nil
    end

    nil
  end
end
