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
        self.nixosModules.gtk
        self.nixosModules.fonts
        self.nixosModules.photography
        self.nixosModules.polkit
        self.nixosModules.wallpapers
      ];

      options.myFeatureGroups.desktop = {
        enable = lib.mkEnableOption "Default Desktop Config";
      };

      config = lib.mkIf cfg.enable {
        myFeatures.clipboard.enable = lib.mkDefault true;
        myFeatures.gtk.enable = lib.mkDefault true;
        myFeatures.fonts.enable = lib.mkDefault true;
        myFeatures.photography.enable = lib.mkDefault true;
        myFeatures.polkit.enable = lib.mkDefault true;
        myFeatures.wallpapers.enable = lib.mkDefault true;

        programs.niri.enable = true;

        hjem.users.rejyr.files.".config/foot/foot.ini".source = ../userConfigs/foot/foot.ini;
        hjem.users.rejyr.files.".config/niri".source = ../userConfigs/niri;
        hjem.users.rejyr.files.".config/noctalia/noctalia-config.toml".source = ../userConfigs/noctalia/noctalia-config.toml;
        environment.systemPackages = with pkgs; [
          inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

          foot
          librewolf
          libnotify
          ungoogled-chromium
          xdg-desktop-portal-gnome
          xwayland-satellite
          zathura

          imv
          mpv
          playerctl
        ];
      };
    };
}
