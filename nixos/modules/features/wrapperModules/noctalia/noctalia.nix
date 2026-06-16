{
  self,
  inputs,
  ...
}:
{
  flake.wrapperModules.noctalia =
    {
      pkgs,
      lib,
      ...
    }:
    let
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      config = {
        package = inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default;
        settings = builtins.fromTOML (builtins.readFile ./noctalia-config.toml);
        # outOfStoreConfig = "~/.config/noctalia";
      };
    };

  perSystem =
    { pkgs, ... }:
    {
      packages.noctalia = inputs.wrapper-modules.wrappers.noctalia-shell.wrap {
        inherit pkgs;
        imports = [ self.wrapperModules.noctalia ];
      };
    };
}
