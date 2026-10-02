{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.bluetooth =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.bluetooth;
    in
    {
      options.myFeatures.bluetooth = {
        enable = lib.mkEnableOption "Bluetooth";
      };

      config = lib.mkIf cfg.enable {
        hardware.bluetooth = {
          enable = true;
          powerOnBoot = true;
        };

        environment.systemPackages = with pkgs; [
          bluetui
        ];
      };
    };
}
