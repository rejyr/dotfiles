{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.fw13 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.fw13Module
      self.nixosModules.myHomeManager
    ];
  };

  flake.nixosModules.fw13Module =
    { pkgs, lib, ... }:
    let
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      imports = [
        self.nixosModules.fw13Hardware
        self.nixosModules.systemGroup
        self.nixosModules.desktopGroup
        self.nixosModules.userRejyr
      ];

      myFeatureGroups.system.enable = true;
      myFeatureGroups.desktop.enable = true;

      myFeatures.userRejyr.enable = true;
      networking.hostName = "fw13";

      environment.systemPackages = with pkgs; [];

      system.stateVersion = "25.11";
    };
}
