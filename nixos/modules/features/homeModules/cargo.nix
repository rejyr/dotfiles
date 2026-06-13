{
  self,
  inputs,
  ...
}:
{
  flake.homeModules.cargo =
    { pkgs, ... }:
    {
      home.file.".cargo/config.toml".text = ''
[target.x86_64-unknown-linux-gnu]
linker = "clang"
rustflags = ["-Clink-arg=--ld-path=wild"]
      '';
    };
}
