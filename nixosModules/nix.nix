{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.nix =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.nix;
    in
    {
      options.myFeatures.nix = {
        enable = lib.mkEnableOption "Nix";
      };

      config = lib.mkIf cfg.enable {
        nixpkgs.config.allowUnfree = true;

        nix.gc = {
          automatic = true;
          dates = "weekly";
          options = "--delete-older-than 7d";
        };

        nix.settings.experimental-features = [
          "nix-command"
          "flakes"
        ];
      };
    };
}
