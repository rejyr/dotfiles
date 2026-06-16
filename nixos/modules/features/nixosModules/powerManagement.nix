{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.powerManagement =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.powerManagement;
    in
    {
      options.myFeatures.powerManagement = {
        enable = lib.mkEnableOption "Power Management";
      };

      config = lib.mkIf cfg.enable {
        powerManagement.enable = true;
        services.tuned.enable = true;
        services.upower.enable = true;
      };
    };
}
