{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.android =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.android;
    in
    {
      options.myFeatures.android = {
        enable = lib.mkEnableOption "Android";
      };

      config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          android-tools
          adb-sync
        ];
      };
    };
}
