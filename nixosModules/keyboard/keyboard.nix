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
      keyboardConfig = {
        services.xserver.xkb = {
          layout = "us";
          variant = "";
        };
      };
      qmkConfig = {
        environment.systemPackages = with pkgs; [
          via
          vial
          qmk-udev-rules
        ];
        hardware.keyboard.qmk.enable = true;
        services.udev.extraRules = lib.mkAfter ''
          KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{serial}=="*vial:f64c2b3c*", MODE="0660", GROUP="users", TAG+="uaccess", TAG+="udev-acl"
        '';
      };
      kanataConfig = {
        environment.systemPackages = with pkgs; [
          kanata
        ];
        services.udev.extraRules = lib.mkAfter ''
          KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
        '';

        services.kanata = {
          enable = true;
          keyboards = {
            defaultKeyboard = {
              devices = [];
              configFile = ./kanata.kbd;
            };
          };
        };
      };
    in
    {
      options.myFeatures.keyboard = {
        enable = lib.mkEnableOption "Keyboard";
        qmk.enable = lib.mkEnableOption "QMK";
        kanata.enable = lib.mkEnableOption "Kanata";
      };

      config = lib.mkIf cfg.enable (
        lib.mkMerge [
          keyboardConfig
          (lib.mkIf cfg.qmk.enable qmkConfig)
          (lib.mkIf cfg.kanata.enable kanataConfig)
        ]
      );
    };
}
