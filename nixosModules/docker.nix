{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.docker =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.docker;
    in
    {
      options.myFeatures.docker = {
        enable = lib.mkEnableOption "Docker";
      };

      config = lib.mkIf cfg.enable {
        virtualisation.docker = {
          enable = true;
          storageDriver = "btrfs";
        };
      };
    };
}
