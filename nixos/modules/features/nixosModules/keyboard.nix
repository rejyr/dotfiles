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
        qmk.enable = lib.mkEnableOption "QMK";
        kanata.enable = lib.mkEnableOption "Kanata";
      };

      config = lib.mkIf cfg.enable {
        services.xserver.xkb = {
          layout = "us";
          variant = "";
        };

        services.udev.extraRules =
          ""
          + lib.optionalString cfg.kanata.enable ''
            KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
          ''
          + lib.optionalString cfg.qmk.enable ''
            KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
          '';

        hardware.keyboard.qmk.enable = cfg.qmk.enable;

        environment.systemPackages =
          with pkgs;
          [
          ]
          ++ lib.optionals cfg.qmk.enable [
            via
            vial
            qmk-udev-rules
          ];
      };
    };
}
