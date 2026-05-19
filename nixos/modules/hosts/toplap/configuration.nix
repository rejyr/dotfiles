{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.toplap = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.toplapModule
      self.nixosModules.myHomeManager
    ];
  };

  flake.nixosModules.toplapModule =
    { pkgs, lib, ... }:
    let
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      imports = [
        self.nixosModules.toplapHardware
        self.nixosModules.systemGroup
        self.nixosModules.desktopGroup
      ];

      myFeatureGroups.system.enable = true;
      myFeatureGroups.desktop.enable = true;

      myFeatures.bootloader = lib.mkForce {
        enable = true;
        extraEntries = ''
          /Windows
              protocol: efi
              path: boot():/EFI/Microsoft/Boot/bootmgfw.efi
        '';
      };

      networking.hostName = "toplap";

      users.users.rejyr = {
        isNormalUser = true;
        description = "Jerry Wang";
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
        packages = with pkgs; [ ];
      };

      nixpkgs.config.allowUnfree = true;

      environment.systemPackages = with pkgs; [];

      nix.gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
      system.stateVersion = "25.11";
      home-manager.users.rejyr = self.homeModules.rejyrModule;
    };
}
