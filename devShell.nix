{ self, inputs, lib, ... }:
{
  perSystem =
    { system, config, ... }:
    let
      # give me unfree packages
      pkgs = import inputs.nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      selfpkgs = config.packages;
    in
    {
      devShells.default = pkgs.mkShell {
        packages = self.shellPackages {
          inherit pkgs selfpkgs;
        };
        shellHook = ''
          ${lib.getExe selfpkgs.fish}
        '';
      };
    };
}
