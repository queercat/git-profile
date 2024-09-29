# TODO: Convert ! to case for more graceful error handling.
# TODO?: Allow for changing the path of the git_profiles.
defmodule Utilities do
  def has_git_profiles? do
    case get_path() |> File.exists?() do
      true ->
        []

      false ->
        prompt_setup()
    end
  end

  def get_path do
    Path.expand("~/.git_profile/profiles.yaml")
  end

  def get_paths do
    [
      Path.expand("~/.git_profile/"),
      Path.expand("~/.git_profile/profiles.yaml")
    ]
  end

  def parse_profiles do
    case get_path() |> YamlElixir.read_all_from_file!() do
      [] -> %{}
      profiles -> hd(profiles)
    end
  end

  def save_profiles(profiles) do
    File.write!(get_path(), Ymlr.document!(profiles))
  end

  def prompt(message) do
    IO.puts(message)
    IO.read(:line) |> String.replace("\n", "")
  end

  defp initialize_directory do
    [directory, file] = get_paths()

    directory |> File.mkdir!()
    file |> File.touch!()
  end

  defp prompt_setup do
    case prompt("Setup profile directory now? [N/y]") |> String.downcase() do
      "y" ->
        initialize_directory()

      _ ->
        IO.puts("This is required to use this CLI tool, so... goodbye :3c")
        System.halt(0)
    end
  end
end
