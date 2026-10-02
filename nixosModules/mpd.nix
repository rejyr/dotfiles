{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.mpd =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.mpd;
    in
    {
      options.myFeatures.mpd = {
        enable = lib.mkEnableOption "mpd";
      };

      config = lib.mkIf cfg.enable {
        # https://github.com/nix-community/home-manager/blob/master/modules/services/mpd.nix
        systemd.user.services.mpd = {
          enable = true;
          after = [
            "network.target"
            "sound.target"
          ];
          wantedBy = [ "default.target" ];
          description = "Music Player Daemon";
          serviceConfig = {
            Type = "notify";
            ExecStart = "${lib.getExe pkgs.mpd} --no-daemon ${../userConfigs/mpd/mpd.conf}";
          };
        };

        # https://github.com/nix-community/home-manager/blob/master/modules/services/mpdris2-rs.nix
        systemd.user.services.mpdris2-rs = {
          enable = true;
          after = [ "mpd.service" ];
          wantedBy = [ "default.target" ];
          description = "Music Player Daemon D-Bus Bridge";
          serviceConfig = {
            Type = "dbus";
            Restart = "on-failure";
            ExecStart = "${lib.getExe pkgs.mpdris2-rs}";

            BusName = "org.mpris.MediaPlayer2.mpd";
          };
        };

        hjem.users.rejyr.files.".config/rmpc".source = ../userConfigs/rmpc;

        environment.systemPackages = with pkgs; [
          mpc
          mpd
          mpdris2-rs
          rmpc
        ];
      };
    };
}
