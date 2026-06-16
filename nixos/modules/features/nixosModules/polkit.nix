{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.polkit =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.polkit;
    in
    {
      options.myFeatures.polkit = {
        enable = lib.mkEnableOption "polkit";
      };

      config = lib.mkIf cfg.enable {
        security.polkit = {
          enable = true;
          # reboot/poweroff for unprivileged users
          # no password for wheel
          # https://wiki.nixos.org/wiki/Polkit
          extraConfig = ''
            polkit.addRule(function (action, subject) {
              if (
                subject.isInGroup("users") &&
                [
                  "org.freedesktop.login1.reboot",
                  "org.freedesktop.login1.reboot-multiple-sessions",
                  "org.freedesktop.login1.power-off",
                  "org.freedesktop.login1.power-off-multiple-sessions",
                ].indexOf(action.id) !== -1
              ) {
                return polkit.Result.YES;
              }
            });
            polkit.addRule(function(action, subject) {
              if (subject.isInGroup("wheel"))
                return polkit.Result.YES;
            });
          '';
        };

        systemd.user.services.polkit-gnome-authentication-agent-1 = {
          description = "polkit-gnome-authentication-agent-1";
          wantedBy = [ "graphical-session.target" ];
          wants = [ "graphical-session.target" ];
          after = [ "graphical-session.target" ];
          serviceConfig = {
            Type = "simple";
            ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
            Restart = "on-failure";
            RestartSec = 1;
            TimeoutStopSec = 10;
          };
        };

        environment.systemPackages = with pkgs; [
          polkit_gnome
        ];
      };
    };
}
