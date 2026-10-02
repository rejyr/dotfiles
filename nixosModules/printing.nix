{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.printing =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.printing;
    in
    {
      options.myFeatures.printing = {
        enable = lib.mkEnableOption "Printing";
      };

      config = lib.mkIf cfg.enable {
        services.printing = {
          enable = true;
          drivers = with pkgs; [
            hplip
            cups-filters
            cups-browsed
          ];
        };

        services.avahi = {
          enable = true;
          nssmdns4 = true;
          openFirewall = true;
        };
      };
    };
}
