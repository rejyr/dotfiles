{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.clipboard =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.clipboard;
    in
    {
      options.myFeatures.clipboard = {
        enable = lib.mkEnableOption "Clipboard";
      };

      config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          cliphist
          wl-clipboard
        ];
      };
    };
}
