{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.shell =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.shell;
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      options.myFeatures.shell = {
        enable = lib.mkEnableOption "Shell Tools";
      };

      config = lib.mkIf cfg.enable {
        environment.systemPackages = with pkgs; [
          selfpkgs.fastfetch
          selfpkgs.neovim
          selfpkgs.nushell
          selfpkgs.zellij

          bat
          bottom
          clang
          dust
          eza
          fd
          fzf
          gcc
          gh
          git
          jq
          ripgrep
          rsync
          skim
          unrar
          unzip
          wild
          yazi
          zip

          imagemagick
        ];
      };
    };
}
