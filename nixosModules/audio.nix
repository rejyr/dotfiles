{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.audio =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.audio;
    in
    {
      options.myFeatures.audio = {
        enable = lib.mkEnableOption "Audio";
      };

      config = lib.mkIf cfg.enable {
        services.pipewire = {
          enable = true;
          pulse.enable = true;
        };

        environment.systemPackages = with pkgs; [
          wiremix
        ];
      };
    };
}
