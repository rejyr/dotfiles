{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.geoclue2 =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.geoclue2;
    in
    {
      options.myFeatures.geoclue2 = {
        enable = lib.mkEnableOption "Geoclue";
      };

      config = lib.mkIf cfg.enable {
        location.provider = "geoclue2";

        services.geoclue2.enable = true;
      };
    };
}
