{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.userRejyr =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.userRejyr;
    in
    {
      options.myFeatures.userRejyr = {
        enable = lib.mkEnableOption "rejyr user";
      };

      config = lib.mkIf cfg.enable {
        users.users.rejyr = {
          isNormalUser = true;
          description = "Jerry Wang";
          extraGroups = [
            "networkmanager"
            "wheel"
            "dialout"
          ];
          packages = with pkgs; [ ];
        };

        home-manager.users.rejyr = self.homeModules.rejyrModule;
      };
    };
}
