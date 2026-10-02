{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.gaming =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.gaming;
    in
    {
      options.myFeatures.gaming = {
        enable = lib.mkEnableOption "Gaming";
      };

      config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          prismlauncher
        ];
      };
    };
}
