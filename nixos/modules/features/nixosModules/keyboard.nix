{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.keyboard =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.keyboard;
    in
    {
      options.myFeatures.keyboard = {
        enable = lib.mkEnableOption "Keyboard";
      };

      config = lib.mkIf cfg.enable {
        services.xserver.xkb = {
          layout = "us";
          variant = "";
        };

        services.udev.extraRules = ''
          KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
          KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
        '';

        hardware.keyboard.qmk.enable = true;

        environment.systemPackages = with pkgs; [
          via
          vial
          qmk-udev-rules
        ];
      };
    };
}
