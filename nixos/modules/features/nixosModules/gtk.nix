{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.gtk =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.gtk;

      theme-name = "Everforest-BL-LB-Dark-Medium";
      icon-theme-name = "Adwaita";
      font-name = "IosevkaNF 11";

      gtksettings = ''
        [Settings]
        gtk-icon-theme-name = ${icon-theme-name}
        gtk-theme-name = ${theme-name}
        gtk-font-name = ${font-name}
      '';
    in
    {
      options.myFeatures.gtk = {
        enable = lib.mkEnableOption "gtk";
      };

      config = lib.mkIf cfg.enable {
        environment = {
          etc = {
            "xdg/gtk-3.0/settings.ini".text = gtksettings;
            "xdg/gtk-4.0/settings.ini".text = gtksettings;
          };
        };

        environment.variables = {
          GTK_THEME = theme-name;
        };

        programs = {
          dconf = {
            enable = lib.mkDefault true;
            profiles = {
              user = {
                databases = [
                  {
                    lockAll = false;
                    settings = {
                      "org/gnome/desktop/interface" = {
                        gtk-theme = theme-name;
                        icon-theme = icon-theme-name;
                        font-name = font-name;
                        color-scheme = "prefer-dark";
                      };
                    };
                  }
                ];
              };
            };
          };
        };

        hjem.users.rejyr.files.".themes".source = ./userConfigs/.themes;
        hjem.users.rejyr.files.".config/gtk-4.0".source = ./userConfigs/.themes/Everforest-BL-LB-Dark-Medium/gtk-4.0;

        environment.systemPackages = with pkgs; [
          gtk3
          gtk4
        ];
      };
    };
}
