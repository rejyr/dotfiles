{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.nvidia =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.nvidia;
    in
    {
      options.myFeatures.nvidia = {
        enable = lib.mkEnableOption "NVIDIA Graphics";
      };

      config = lib.mkIf cfg.enable {
        services.xserver.videoDrivers = [ "nvidia" ];
        hardware.nvidia = {
          modesetting.enable = true;
          powerManagement.enable = false;
          powerManagement.finegrained = false;
          open = true;
          nvidiaSettings = true;
          package = config.boot.kernelPackages.nvidiaPackages.stable;
        };
      };
    };
}
