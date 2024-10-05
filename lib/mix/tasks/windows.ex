defmodule Mix.Tasks.Windows do
  use Mix.Task

  @root_path Path.expand("~/.bin")

  def generate_powershell do
    powershell_script = """
    $arguments = $args -join ' '
    escript.exe #{@root_path}/gitp $arguments
    """

    File.write!("gitp.ps1", powershell_script)
  end

  def format_path(path) do
    path
  end

  def move_to_usr_bin do
    System.cmd("mv", ["gitp", @root_path])
    System.cmd("mv", ["gitp.ps1", @root_path])
  end

  def run(_) do
    Mix
      .shell()
      .cmd("mix escript.build")

    System.cmd("mkdir", ["-p", @root_path])

    generate_powershell()
    move_to_usr_bin()

    Mix.shell().info("gitp installed successfully!")
  end
end
