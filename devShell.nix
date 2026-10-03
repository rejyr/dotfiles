{ self, inputs, ... }:
{
  perSystem =
    { system, config, ... }:
    let
      # give me unfree packages
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      devShells.default = pkgs.mkShell {
        packages = self.shellPackages {
          inherit pkgs;
          selfpkgs = config.packages;
        };
        shellHook = ''
          exec fish
        '';
      };
    };
}
