{
  self,
  inputs,
  ...
}:
{
  flake.nixosConfigurations.fw13 = inputs.nixpkgs.lib.nixosSystem {
    modules = [
      self.nixosModules.fw13Module
      inputs.hjem.nixosModules.default
    ];
  };

  flake.nixosModules.fw13Module =
    { pkgs, lib, ... }:
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

      # for zotero
      nixpkgs.config.permittedInsecurePackages = [
        "firefox-esr-140-bin-unwrapped-140.17.0esr"
      ];

      environment.systemPackages = with pkgs; [
        vscode
        zotero
        gleam
      ];

      system.stateVersion = "25.11";
    };
}
