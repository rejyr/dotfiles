{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.systemGroup =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatureGroups.system;
    in
    {
      imports = [
        self.nixosModules.audio
        self.nixosModules.android
        self.nixosModules.bluetooth
        self.nixosModules.bootloader
        self.nixosModules.geoclue2
        self.nixosModules.keyboard
        self.nixosModules.networking
        self.nixosModules.powerManagement
        self.nixosModules.shellTools
        self.nixosModules.texlive
        self.nixosModules.tzLocale
      ];

      options.myFeatureGroups.system = {
        enable = lib.mkEnableOption "Default System Config";
      };

      config = lib.mkIf cfg.enable {
        myFeatures.audio.enable = lib.mkDefault true;
        myFeatures.android.enable = lib.mkDefault true;
        myFeatures.bluetooth.enable = lib.mkDefault true;
        myFeatures.bootloader.enable = lib.mkDefault true;
        myFeatures.geoclue2.enable = lib.mkDefault true;
        myFeatures.keyboard.enable = lib.mkDefault true;
        myFeatures.keyboard.qmk.enable = lib.mkDefault true;
        myFeatures.keyboard.kanata.enable = lib.mkDefault true;
        myFeatures.networking.enable = lib.mkDefault true;
        myFeatures.powerManagement.enable = lib.mkDefault true;
        myFeatures.shellTools.enable = lib.mkDefault true;
        myFeatures.texlive.enable = lib.mkDefault true;
        myFeatures.tzLocale.enable = lib.mkDefault true;

        environment.systemPackages = with pkgs; [
          bash
          nh
          nixfmt
          python3
          rustup
          uv
        ];
      };
    };
}
