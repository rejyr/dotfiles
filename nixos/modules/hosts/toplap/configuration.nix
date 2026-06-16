{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.toplap = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.toplapModule
      inputs.hjem.nixosModules.default
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
        self.nixosModules.userRejyr
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

      myFeatures.userRejyr.enable = true;
      networking.hostName = "toplap";

      environment.systemPackages = with pkgs; [];

      system.stateVersion = "25.11";
    };
}
