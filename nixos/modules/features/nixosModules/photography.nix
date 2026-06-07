{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.photography =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.photography;
    in
    {
      options.myFeatures.photography = {
        enable = lib.mkEnableOption "Photography";
      };

      config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          darktable
        ];
      };
    };
}
