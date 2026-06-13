{
  self,
  inputs,
  ...
}:
{
  flake.wrapperModules.nushell =
    {
      pkgs,
      lib,
      ...
    }:
    {
      config = {
        runtimePkgs = with pkgs; [
          atuin
          carapace
          starship
          zoxide
        ];
        env.STARSHIP_CONFIG = ./starship.toml;
        "config.nu".content =
          let
            preConfig = "";
            postConfig = "";
          in
          preConfig + (builtins.readFile ./config.nu) + postConfig;
      };
    };

  perSystem =
    {
      pkgs,
      lib,
      self',
      ...
    }:
    {
      packages.nushell = inputs.wrapper-modules.wrappers.nushell.wrap {
        inherit pkgs;
        imports = [ self.wrapperModules.nushell ];
      };
    };
}
