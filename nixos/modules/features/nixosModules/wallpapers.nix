{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.wallpapers =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.wallpapers;
    in
    {
      options.myFeatures.wallpapers = {
        enable = lib.mkEnableOption "Wallpapers";
      };

      config = lib.mkIf cfg.enable {
        hjem.users.rejyr.files."Wallpapers".source = pkgs.fetchFromGitHub {
          owner = "rejyr";
          repo = "everforest-walls";
          rev = "edcda2a";
          sha256 = "sha256-ahXnaemauM2V8xxQHtyYJEczbBndjLqJhFymPOaQN58=";
        };
      };
    };
}
