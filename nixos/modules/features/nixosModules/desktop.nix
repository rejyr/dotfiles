{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.desktopGroup =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatureGroups.desktop;
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      imports = [
        self.nixosModules.clipboard
        self.nixosModules.fonts
      ];

      options.myFeatureGroups.desktop = {
        enable = lib.mkEnableOption "Default Desktop Config";
      };

      config = lib.mkIf cfg.enable {
        myFeatures.clipboard.enable = lib.mkDefault true;
        myFeatures.fonts.enable = lib.mkDefault true;

        programs.niri = {
          enable = true;
          package = selfpkgs.niri;
        };

        environment.systemPackages = with pkgs; [
          selfpkgs.foot
          selfpkgs.fuzzel
          selfpkgs.mako
          selfpkgs.waybar
          selfpkgs.zathura

          libnotify

          imv
          mpv
          playerctl
        ];
      };
    };
}
