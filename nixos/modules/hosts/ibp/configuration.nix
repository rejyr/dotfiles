{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.ibp = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.ibpModule
      inputs.hjem.nixosModules.default
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

      myFeatures.nvidia.enable = true;

      myFeatures.userRejyr.enable = true;
      networking.hostName = "ibp";

      environment.systemPackages = with pkgs; [
        # TODO: nixos module?
        arduino-ide
        freecad
        kicad
        orca-slicer
      ];

      system.stateVersion = "25.11";
    };
}
