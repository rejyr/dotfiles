{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.fonts =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.fonts;
    in
    {
      options.myFeatures.fonts = {
        enable = lib.mkEnableOption "Fonts";
      };

      config = lib.mkIf cfg.enable {
        fonts.packages = with pkgs; [
          nerd-fonts.iosevka
          sarasa-gothic
          noto-fonts-color-emoji
        ];
      };
    };
}
