{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.networking =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.networking;
    in
    {
      options.myFeatures.networking = {
        enable = lib.mkEnableOption "Networking";
      };

      config = lib.mkIf cfg.enable {
        networking.networkmanager.enable = true;
      };
    };
}
