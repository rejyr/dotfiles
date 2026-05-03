{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.ibp = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.ibpModule
      self.nixosModules.myHomeManager
    ];
  };

  flake.nixosModules.ibpModule =
    { pkgs, lib, ... }:
    let
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      imports = [
        self.nixosModules.ibpHardware
        self.nixosModules.systemGroup
        self.nixosModules.desktopGroup
        self.nixosModules.nvidia
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

      myFeatures.nvidia.enable = true;

      networking.hostName = "ibp";

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

      environment.systemPackages = with pkgs; [
        bash
        nixfmt
        python3
        rustup
        uv
      ];

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
