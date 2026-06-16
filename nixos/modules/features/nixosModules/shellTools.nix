{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.shellTools =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    let
      cfg = config.myFeatures.shellTools;
      selfpkgs = self.packages."${pkgs.stdenv.hostPlatform.system}";
    in
    {
      options.myFeatures.shellTools = {
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
