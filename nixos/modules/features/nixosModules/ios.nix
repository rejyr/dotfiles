{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.ios =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.ios;
    in
    {
      options.myFeatures.ios = {
        enable = lib.mkEnableOption "IOS";
      };

      config = lib.mkIf cfg.enable {
        services.usbmuxd.enable = true;

        environment.systemPackages = with pkgs; [
          libimobiledevice
          ifuse
        ];
      };
    };
}
