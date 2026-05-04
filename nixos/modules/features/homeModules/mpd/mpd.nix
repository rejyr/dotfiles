{
  self,
  inputs,
  ...
}:
{
  flake.homeModules.mpd =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        mpc
        rmpc
      ];

      services.mpd = {
        enable = true;
        musicDirectory = "~/Music";
        dbFile = "~/.mpd/database";
      };
      services.mpdris2-rs.enable = true;
      xdg.configFile.rmpc.source = ./rmpc;
    };
}
