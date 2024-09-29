defmodule GitProfile do
  import Utilities

  def main(args) do
    args
    |> OptionParser.parse(strict: [help: :boolean, global: :boolean], aliases: [g: :global])
    |> process_arguments
  end

  defp process_arguments({_, _, [_ | _]}) do
    IO.puts("An error has occured!")
  end

  defp process_arguments({[help: true], _, _}), do: show_usage()
  defp process_arguments({_, [], _}), do: show_usage()

  defp process_arguments({options, arguments, _}) do
    has_git_profiles?()

    global =
      options
      |> Keyword.has_key?(:global)

    case arguments |> hd do
      "list" ->
        Actions.List.list_profiles()

      "switch" ->
        case arguments do
          [_, profile_name] ->
            Actions.Switch.switch_profile(profile_name, global)

          [_] ->
            IO.puts("Expected 1 argument")
            show_usage(1)
        end

      "new" ->
        case arguments do
          [_, profile_name, email, first_name, last_name] ->
            Actions.New.new_profile(profile_name, email, first_name <> " " <> last_name, global)

          [_, profile_name, email, name] ->
            Actions.New.new_profile(profile_name, email, name, global)

          _ ->
            IO.puts("Expected 3 - 4 arguments")
            show_usage(1)
        end

      "delete" ->
        case arguments do
          [_, profile_name] ->
            Actions.Delete.delete_profile(profile_name)

          _ ->
            IO.puts("Expected 1 argument")
            show_usage(1)
        end

      "generate" ->
        case arguments do
          [_] ->
            Actions.Generate.generate_profile("Default", global)

          [_, profile_name] ->
            Actions.Generate.generate_profile(profile_name, global)

          _ ->
            IO.puts("Expected 0 - 1 arguments.")
            show_usage(1)
        end

      _ ->
        show_usage()
    end

    System.halt(0)
  end

  defp show_usage(status \\ 0) do
    IO.puts("Commands:")
    IO.puts(" - list/0: Lists profiles available in ~/.git_profile/.profiles.")

    IO.puts(
      " - new/3 {profile_name} {email} {name}: Adds a new profile to ~/.git_profile/.profiles."
    )

    IO.puts(
      " - new/4 {profile_name} {email} {first_name} {last_name}: Adds a new profile to ~/.git_profile/.profiles."
    )

    IO.puts(
      " - generate/0: Adds a new profile named \"Default\" with the current git configuration."
    )

    IO.puts(
      " - generate/1 {profile_name}: Adds a new profile named {profile_name} with the current git configuration."
    )

    IO.puts(
      " - delete/1 {profile_name}: Deletes the profile with {profile_name} from ~/.git_profile/.profiles."
    )

    IO.puts(" - switch/1 {profile_name}: Switches the current git profile to {profile_name}.")

    IO.puts("Flags:")

    IO.puts(
      "  --global, -g: Attempts to invoke a git command globally, (can also be useful if you're not in a git directory.)"
    )

    IO.puts("  --help, help: Lists the usage information!")

    System.halt(status)
    nil
  end
end
